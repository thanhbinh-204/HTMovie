import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieService {
  static const String baseUrl = "https://movie-server-mlom.onrender.com";

  //get all movie
  static Future<List<MovieModel>> getAllMovies() async {
    final url = Uri.parse("$baseUrl/movies");
    final reponse = await http.get(url);

    if (reponse.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(reponse.body);

      final List list = json['data']['records'];

      return list.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load movies");
    }
  }

  //search by title
  static Future<List<MovieModel>> searchMovieByTitle(String title) async {
    final encodedTitle = Uri.encodeQueryComponent(title);
    final url = Uri.parse("$baseUrl/movies/search?q=$encodedTitle");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);

      final List list = json['data']['records'];

      return list.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw Exception("Search movie failed");
    }
  }

  //get movie by id (details)
  static Future<MovieModel> getMovieDetail(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/movies/$id/detail"));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return MovieModel.fromJson(json['data']);
    } else {
      throw Exception('Failed to load movie detail');
    }
  }
}
