import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RatingService {

  // post rating
  static Future<Map<String, dynamic>> rateMovie({
    required String token,
    required String movieId,
    required int score,
  }) async {
    final response = await http.post(
      Uri.parse('https://movie-server-mlom.onrender.com/ratings/rate'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'movieId': movieId, 'score': score}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      debugPrint('RATE ERROR ${response.statusCode}: ${response.body}');
      throw Exception('Rate movie failed');
    }

    final data = jsonDecode(response.body);
    return data['data']['rating'] as Map<String, dynamic>;
  }


  //get rating
  static Future<List<dynamic>> getRatingsByMovieId(String movieId) async {
    final response = await http.get(
      Uri.parse(
        'https://movie-server-mlom.onrender.com/ratings/getrate?movieId=$movieId',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Get ratings failed');
    }

    final data = jsonDecode(response.body);
    return data['data']['ratings'] as List<dynamic>;
  }
}
