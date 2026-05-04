import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_random_joke.dart';
import '../../domain/usecases/manage_saved_jokes.dart';
import 'joke_event.dart';
import 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final GetRandomJokeUseCase getRandomJoke;
  final ManageSavedJokesUseCase manageSavedJokes;

  JokeBloc({required this.getRandomJoke, required this.manageSavedJokes})
    : super(JokeInitial()) {
    on<LoadRandomJokeEvent>((event, emit) async {
      emit(JokeLoading());
      try {
        final joke = await getRandomJoke.execute();
        emit(JokeLoaded(joke));
      } catch (e) {
        emit(JokeError(e.toString()));
      }
    });

    on<SaveCurrentJokeEvent>((event, emit) async {
      await manageSavedJokes.saveJoke(event.joke);
      // We don't change state here to keep the user on the current joke screen
    });

    on<LoadSavedJokesEvent>((event, emit) async {
      emit(JokeLoading());
      final jokes = await manageSavedJokes.getSaved();
      emit(SavedJokesLoaded(jokes));
    });
  }
}
