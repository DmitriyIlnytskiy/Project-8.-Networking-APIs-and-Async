// lib/features/joke/data/repositories/joke_repository_impl.dart
import '../../../domain/entities/joke_entity.dart';
import '../../../domain/repositories/joke_repository.dart';
import '../joke_local_data_source.dart';
import '../../datasources/joke_remote_data_source.dart';
import '../../models/joke_model.dart';

/// Connects the data sources to the domain rules.
class JokeRepositoryImpl implements JokeRepository {
  final JokeRemoteDataSource remoteDataSource;
  final JokeLocalDataSource localDataSource;

  JokeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<JokeEntity> getRandomJoke() async {
    return await remoteDataSource.fetchRandomJoke();
  }

  @override
  Future<void> saveJoke(JokeEntity joke) async {
    final model = JokeModel(
      id: joke.id,
      setup: joke.setup,
      punchline: joke.punchline,
    );
    localDataSource.saveJoke(model);
  }

  @override
  Future<List<JokeEntity>> getSavedJokes() async {
    return localDataSource.getSavedJokes();
  }
}
