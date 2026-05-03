// lib/features/joke/data/models/joke_model.dart
import '../../domain/entities/joke_entity.dart';

/// Extends the entity to add JSON serialization (data layer responsibility)
class JokeModel extends JokeEntity {
  JokeModel({
    required super.id,
    required super.setup,
    required super.punchline,
  });

  factory JokeModel.fromJson(Map<String, dynamic> json) {
    return JokeModel(
      id: json['id'] ?? 0,
      setup: json['setup'] ?? '',
      punchline: json['punchline'] ?? '',
    );
  }
}
