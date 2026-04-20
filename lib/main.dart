// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/joke_bloc.dart';
import 'bloc/joke_event.dart';
import 'screens/joke_screen.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Practice App BLoC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Provide the BLoC to the app and trigger the first fetch
      home: BlocProvider(
        create: (context) => JokeBloc(ApiService())..add(GetRandomJoke()),
        child: const JokeScreen(),
      ),
    );
  }
}
