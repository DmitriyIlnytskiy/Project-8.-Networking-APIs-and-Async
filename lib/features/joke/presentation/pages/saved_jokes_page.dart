// lib/features/joke/presentation/pages/saved_jokes_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/joke_bloc.dart';
import '../bloc/joke_event.dart';
import '../bloc/joke_state.dart';

class SavedJokesPage extends StatefulWidget {
  const SavedJokesPage({super.key});

  @override
  State<SavedJokesPage> createState() => _SavedJokesPageState();
}

class _SavedJokesPageState extends State<SavedJokesPage> {
  @override
  void initState() {
    super.initState();
    // Fetch saved jokes when screen loads
    context.read<JokeBloc>().add(LoadSavedJokesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Jokes')),
      body: BlocBuilder<JokeBloc, JokeState>(
        builder: (context, state) {
          if (state is JokeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SavedJokesLoaded) {
            if (state.jokes.isEmpty) {
              return const Center(child: Text('No jokes saved yet!'));
            }
            return ListView.builder(
              itemCount: state.jokes.length,
              itemBuilder: (context, index) {
                final joke = state.jokes[index];
                return ListTile(
                  title: Text(joke.setup),
                  subtitle: Text(joke.punchline),
                  leading: const Icon(Icons.star, color: Colors.amber),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      // Important: When going back, reload a random joke so the Home Page works again
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<JokeBloc>().add(LoadRandomJokeEvent());
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
