import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/joke_bloc.dart';
import '../bloc/joke_event.dart';
import '../bloc/joke_state.dart';
import 'saved_jokes_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Arch Jokes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              // Navigate to the new feature screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SavedJokesPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: BlocBuilder<JokeBloc, JokeState>(
            buildWhen: (previous, current) =>
                current is! SavedJokesLoaded, // Don't rebuild home with list
            builder: (context, state) {
              if (state is JokeLoading || state is JokeInitial) {
                return const CircularProgressIndicator();
              } else if (state is JokeError) {
                return Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                );
              } else if (state is JokeLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.joke.setup,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.joke.punchline,
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => context.read<JokeBloc>().add(
                            LoadRandomJokeEvent(),
                          ),
                          icon: const Icon(Icons.refresh),
                          label: const Text('New'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<JokeBloc>().add(
                              SaveCurrentJokeEvent(state.joke),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Joke saved!')),
                            );
                          },
                          icon: const Icon(Icons.save),
                          label: const Text('Save'),
                        ),
                      ],
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
