import 'dart:convert';
import '../api/../models/watch_history_model.dart';
import 'package:http/http.dart' as http;

class WatchHistoryService {
  static const String _baseUrl = 'https://movie-server-mlom.onrender.com';

  static Future<List<WatchHistoryModel>> getWatchHistory({
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/histories/watch-history'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == 'success') {
      final List list = data['data']['history'] ?? [];
      return list 
          .map((e) => WatchHistoryModel.fromJson(e))
          .toList();
    }
    throw Exception(data['message'] ?? 'Load watch history failed');
  }
}
