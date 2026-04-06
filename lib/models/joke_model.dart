// lib/models/joke_model.dart

class Joke {
  final String setup;
  final String punchline;

  Joke({required this.setup, required this.punchline});

  // Factory constructor for JSON parsing
  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'] ?? 'No setup provided',
      punchline: json['punchline'] ?? 'No punchline provided',
    );
  }
}
