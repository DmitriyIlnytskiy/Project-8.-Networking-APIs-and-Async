import 'package:flutter_bloc/flutter_bloc.dart';
import 'joke_event.dart';
import 'joke_state.dart';
import '../services/api_service.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final ApiService apiService;

  JokeBloc(this.apiService) : super(JokeInitial()) {
    // Listen for the GetRandomJoke event
    on<GetRandomJoke>((event, emit) async {
      emit(JokeLoading()); // Immediately tell the UI to show a loader

      try {
        // Await the API call
        final joke = await apiService.fetchRandomJoke();
        emit(JokeLoaded(joke)); // Tell the UI we have data
      } catch (e) {
        emit(JokeError(e.toString())); // Tell the UI an error occurred
      }
    });
  }
}
