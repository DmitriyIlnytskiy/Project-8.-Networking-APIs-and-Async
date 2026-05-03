// lib/features/joke/domain/repositories/joke_repository.dart
import '../entities/joke_entity.dart';

/// Abstract contract that the Data layer must fulfill.
abstract class JokeRepository {
  Future<JokeEntity> getRandomJoke();
  Future<void> saveJoke(JokeEntity joke);
  Future<List<JokeEntity>> getSavedJokes();
}
