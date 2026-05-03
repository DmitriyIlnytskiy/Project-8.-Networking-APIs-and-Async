import '../models/joke_model.dart';

class JokeLocalDataSource {
  // 1. Explicitly type the list as <JokeModel> here:
  final List<JokeModel> _savedJokes = [];

  void saveJoke(JokeModel joke) {
    if (!_savedJokes.any((j) => j.id == joke.id)) {
      _savedJokes.add(joke);
    }
  }

  // 2. Explicitly set the return type as List<JokeModel> here:
  List<JokeModel> getSavedJokes() {
    return _savedJokes;
  }
}
