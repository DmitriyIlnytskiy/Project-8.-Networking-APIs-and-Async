import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../core/config/api_keys.dart';
import '../models/joke_model.dart';

class JokeRemoteDataSource {
  Future<JokeModel> fetchRandomJoke() async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/random_joke'),
    );
    if (response.statusCode == 200) {
      return JokeModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Server error');
    }
  }
}
