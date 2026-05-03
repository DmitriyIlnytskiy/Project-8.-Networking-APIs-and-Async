// lib/features/joke/domain/entities/joke_entity.dart

/// Represents the core business object of a Joke.
/// Notice it doesn't have any JSON parsing logic!
class JokeEntity {
  final int id;
  final String setup;
  final String punchline;

  JokeEntity({required this.id, required this.setup, required this.punchline});
}
