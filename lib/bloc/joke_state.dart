import '../models/joke_model.dart';

abstract class JokeState {}

class JokeInitial extends JokeState {} // Starting state

class JokeLoading extends JokeState {} // State 1: Loading

class JokeLoaded extends JokeState {
  // State 2: Loaded
  final Joke joke;
  JokeLoaded(this.joke);
}

class JokeError extends JokeState {
  // State 3: Error
  final String message;
  JokeError(this.message);
}
