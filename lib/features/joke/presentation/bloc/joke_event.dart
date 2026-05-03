// lib/features/joke/presentation/bloc/joke_event.dart
abstract class JokeEvent {}

class LoadRandomJokeEvent extends JokeEvent {}

class SaveCurrentJokeEvent extends JokeEvent {
  final dynamic joke; // Passing the joke to save
  SaveCurrentJokeEvent(this.joke);
}

class LoadSavedJokesEvent extends JokeEvent {}
