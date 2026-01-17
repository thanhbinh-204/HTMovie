// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/comment_model.dart';

// class CommentService {
//   static const String _baseUrl = 'https://movie-server-mlom.onrender.com';

//   //post comment
//   static Future<CommentModel> createComment({
//     required String movieId,
//     required String content,
//     String? parentId,
//     required String accessToken,
//   }) async {
//     final url = Uri.parse('$_baseUrl/comments/create-comment');

//     final body = {
//       'movieId': movieId,
//       'content': content,
//       if (parentId != null) 'parentId': parentId,
//     };

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $accessToken',
//       },
//       body: jsonEncode(body),
//     );
//     final json = jsonDecode(response.body);
//     print("API Response: $json");

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       return CommentModel.fromJson(json['data']['comment']);
//     } else {
//       throw Exception(json['message'] ?? 'Create comment failed');
//     }
//   }

//   //get comment
//   static Future<List<CommentModel>> getComments(String movieId) async {
//     final url = Uri.parse('$_baseUrl/comments/$movieId/comments');
//     final response = await http.get(url);
//     final json = jsonDecode(response.body);

//     if (response.statusCode == 200) {
//       final data = json['data'];
//       if (data == null) return [];

//       final records = data['records'];

//       if (records == null || records is! List) return [];

//       return records
//           .map<CommentModel>((e) => CommentModel.fromJson(e))
//           .toList();
//     } else {
//       throw Exception(json['message'] ?? 'Get comment failed');
//     }
//   }
// }


import 'dart:convert';
import 'package:ht_movie/call_api/services/authstorage.dart';
import 'package:http/http.dart' as http;
import '../models/comment_model.dart';

class CommentService {
  static const String _baseUrl = 'https://movie-server-mlom.onrender.com';

  /// CREATE COMMENT
  static Future<CommentModel> createComment({
    required String movieId,
    required String content,
    String? parentId,
  }) async {
    final accessToken = await Authstorage.getAccessToken();
    if (accessToken == null) {
      throw Exception('User not logged in');
    }

    final url = Uri.parse('$_baseUrl/comments/create-comment');

    final body = {
      'movieId': movieId,
      'content': content,
      if (parentId != null) 'parentId': parentId,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(body),
    );

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return CommentModel.fromJson(decoded['data']['comment']);
    } else {
      throw Exception(decoded['message'] ?? 'Create comment failed');
    }
  }

  /// GET COMMENTS
  static Future<List<CommentModel>> getComments(String movieId) async {
    final url = Uri.parse('$_baseUrl/comments/$movieId/comments');

    final response = await http.get(url);
    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final records = decoded['data']?['records'];
      if (records == null || records is! List) return [];

      return records
          .map<CommentModel>((e) => CommentModel.fromJson(e))
          .toList();
    } else {
      throw Exception(decoded['message'] ?? 'Get comment failed');
    }
  }
}
