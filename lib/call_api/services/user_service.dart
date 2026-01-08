// import 'package:flutter/foundation.dart';
// import '../models/user_model.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class UserService {
//   static const String baseUrl = 'https://movie-server-mlom.onrender.com';

//   static Future<UserModel> getProfile({required String token}) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/auth/me'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     debugPrint('STATUS CODE: ${response.statusCode}');
//     debugPrint('RESPONSE BODY: ${response.body}');
//     final data = jsonDecode(response.body);

//     if (response.statusCode == 200 && data['user'] != null) {
//       return UserModel.fromJson(data['user']);
//     }
//     throw Exception('Failed to fetch user profile');
//   }
// }


import '../models/user_model.dart';
import '../api/api_client.dart';

class UserService {
  static final ApiClient _apiClient = ApiClient();

  static Future<UserModel> getProfile() async {
    final data = await _apiClient.get(
      '/auth/me',
      requireAuth: true,
    );

    if (data['user'] != null) {
      return UserModel.fromJson(data['user']);
    }

    throw Exception('User data not found');
  }
}
