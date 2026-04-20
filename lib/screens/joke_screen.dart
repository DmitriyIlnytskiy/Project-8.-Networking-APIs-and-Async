// lib/screens/joke_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/joke_bloc.dart';
import '../bloc/joke_event.dart';
import '../bloc/joke_state.dart';

class JokeScreen extends StatelessWidget {
  const JokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLoC Joke API'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          // BlocBuilder automatically listens to JokeBloc states
          child: BlocBuilder<JokeBloc, JokeState>(
            builder: (context, state) {
              if (state is JokeInitial || state is JokeLoading) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading a funny joke...'),
                  ],
                );
              } else if (state is JokeError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${state.message}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      // Dispatch a new event to the BLoC to try again
                      onPressed: () =>
                          context.read<JokeBloc>().add(GetRandomJoke()),
                      child: const Text('Try Again'),
                    ),
                  ],
                );
              } else if (state is JokeLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.joke.setup,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      state.joke.punchline,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 48),
                    ElevatedButton.icon(
                      // Dispatch a new event to the BLoC to fetch another joke
                      onPressed: () =>
                          context.read<JokeBloc>().add(GetRandomJoke()),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Get Another Joke'),
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
