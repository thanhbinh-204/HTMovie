import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieService {
  static const String baseUrl = "https://movie-server-mlom.onrender.com";

  static Future<List<MovieModel>> getAllMovies() async {
    final url = Uri.parse("$baseUrl/movies");
    final reponse = await http.get(url);

    if (reponse.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(reponse.body);

      final List list = json['results']['results'];

      return list.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }
}

