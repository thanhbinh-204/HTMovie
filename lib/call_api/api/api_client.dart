import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_endpoints.dart';
import '../authstorage.dart';

// class ApiClient {
//   Future<dynamic> get(String endpoints) async {
//     final url = Uri.parse(ApiEndpoints.baseUrl + endpoints);
//     debugPrint('call api: $url');

//     final response = await http.get(url);

//     debugPrint('STATUS CODE: ${response.statusCode}');
    

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('API error ${response.statusCode}');
//     }
//   }
// }

class ApiClient {

  /// GET API (có/không token)
  Future<dynamic> get(
    String endpoint, {
    bool requireAuth = false,
  }) async {
    final url = Uri.parse(ApiEndpoints.baseUrl + endpoint);
    debugPrint('CALL API: $url');

    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    if (requireAuth) {
      final token = await Authstorage.getAccessToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    final response = await http.get(url, headers: headers);

    debugPrint('STATUS CODE: ${response.statusCode}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    if (response.statusCode == 401) {
      throw UnauthenticatedException();
    }

    throw Exception('API error ${response.statusCode}');
  }
}

/// Custom Exception
class UnauthenticatedException implements Exception {}
