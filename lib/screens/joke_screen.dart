// lib/screens/joke_screen.dart

import 'package:flutter/material.dart';
import '../models/joke_model.dart';
import '../services/api_service.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  final ApiService _apiService = ApiService();
  late Future<Joke> _jokeFuture;

  @override
  void initState() {
    super.initState();
    _loadJoke();
  }

  void _loadJoke() {
    setState(() {
      _jokeFuture = _apiService.fetchRandomJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Joke API'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FutureBuilder<Joke>(
            future: _jokeFuture,
            builder: (context, snapshot) {
              // State 1: Loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading a funny joke...'),
                  ],
                );
              }
              // State 2: Error
              else if (snapshot.hasError) {
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
                      'Error: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadJoke,
                      child: const Text('Try Again'),
                    ),
                  ],
                );
              }
              // State 3: Loaded
              else if (snapshot.hasData) {
                final joke = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      joke.setup,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      joke.punchline,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 48),
                    ElevatedButton.icon(
                      onPressed: _loadJoke,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Get Another Joke'),
                    ),
                  ],
                );
              }

              // Fallback just in case
              return const Text('No data available');
            },
          ),
        ),
      ),
    );
  }
}
