import '../entities/joke_entity.dart';
import '../repositories/joke_repository.dart';

/// Use case dedicated to our new feature: Saving and loading favorites.
class ManageSavedJokesUseCase {
  final JokeRepository repository;

  ManageSavedJokesUseCase(this.repository);

  Future<void> saveJoke(JokeEntity joke) async {
    await repository.saveJoke(joke);
  }

  Future<List<JokeEntity>> getSaved() async {
    return await repository.getSavedJokes();
  }
}
