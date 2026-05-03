// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/joke/data/datasources/joke_local_data_source.dart';
import 'features/joke/data/datasources/joke_remote_data_source.dart';
import 'features/joke/data/datasources/repositories/joke_repository_impl.dart';
import 'features/joke/domain/usecases/get_random_joke.dart';
import 'features/joke/domain/usecases/manage_saved_jokes.dart';
import 'features/joke/presentation/bloc/joke_bloc.dart';
import 'features/joke/presentation/bloc/joke_event.dart';
import 'features/joke/presentation/pages/home_page.dart';

void main() {
  // Manual Dependency Injection
  final remoteDataSource = JokeRemoteDataSource();
  final localDataSource = JokeLocalDataSource();
  final repository = JokeRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final JokeRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    // 1. We moved the BlocProvider UP to wrap the MaterialApp
    return BlocProvider(
      create: (_) => JokeBloc(
        getRandomJoke: GetRandomJokeUseCase(repository),
        manageSavedJokes: ManageSavedJokesUseCase(repository),
      )..add(LoadRandomJokeEvent()),

      // 2. Now the MaterialApp (and all its routes) is a child of the BLoC
      child: MaterialApp(
        title: 'Clean Architecture Jokes',
        theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
        home: const HomePage(), // HomePage is now clean and simple
      ),
    );
  }
}
