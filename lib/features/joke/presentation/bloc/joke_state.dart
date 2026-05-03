// lib/features/joke/presentation/bloc/joke_state.dart
import '../../domain/entities/joke_entity.dart';

abstract class JokeState {}

class JokeInitial extends JokeState {}

class JokeLoading extends JokeState {}

class JokeLoaded extends JokeState {
  final JokeEntity joke;
  JokeLoaded(this.joke);
}

class JokeError extends JokeState {
  final String message;
  JokeError(this.message);
}

// New state for the new feature screen
class SavedJokesLoaded extends JokeState {
  final List<JokeEntity> jokes;
  SavedJokesLoaded(this.jokes);
}
