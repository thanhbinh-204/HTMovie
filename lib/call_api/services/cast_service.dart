import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/cast_model.dart';

class CastService {
  static const String baseUrl =
      'https://movie-server-mlom.onrender.com';

  static Future<List<CastModel>> getCastsByMovieId(String movieId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/movies/$movieId/detail'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load movie detail');
    }

    final data = jsonDecode(response.body);
    final List movieCasts = data['data']['movieCasts'];

    return movieCasts.map<CastModel>((item) {
      final cast = item['cast'];
      return CastModel(
        id: cast['id'],
        name: cast['name'],
        profileUrl: cast['profileUrl'],
      );
    }).toList();
  }
}