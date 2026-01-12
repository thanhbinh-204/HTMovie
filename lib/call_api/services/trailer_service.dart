import 'dart:convert';
import 'package:ht_movie/call_api/models/trailer_model.dart';
import 'package:http/http.dart' as http;

class TrailerService {
  static Future<List<TrailerModel>> getTrailers(String movieId) async {
    final url = Uri.parse(
      'https://movie-server-mlom.onrender.com/trailers/movie/$movieId',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List list = data['trailers'] ?? [];
      return list.map((e) => TrailerModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}