// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke_model.dart';
import '../config/api_key.dart';

class ApiService {
  // Fetch a random joke from the API
  Future<Joke> fetchRandomJoke() async {
    final url = Uri.parse('${ApiConfig.baseUrl}/random_joke');

    // Using async/await for the network request
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON string into a Map, then into our Model class
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return Joke.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load joke. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
