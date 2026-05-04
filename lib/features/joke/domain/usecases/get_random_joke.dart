import '../entities/joke_entity.dart';
import '../repositories/joke_repository.dart';

/// Use case dedicated to fetching a random joke.
class GetRandomJokeUseCase {
  final JokeRepository repository;

  GetRandomJokeUseCase(this.repository);

  Future<JokeEntity> execute() async {
    return await repository.getRandomJoke();
  }
}
