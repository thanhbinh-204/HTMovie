import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_endpoints.dart';
import '../services/authstorage.dart';
import '../api/../services/auth_service.dart';

class ApiClient {
  Future<dynamic> get(String endpoint, {bool requireAuth = false}) async {
    final url = Uri.parse(ApiEndpoints.baseUrl + endpoint);

    final headers = <String, String>{'Content-Type': 'application/json'};

    if (requireAuth) {
      final token = await Authstorage.getAccessToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    http.Response response = await http.get(url,headers: headers);

      if (response.statusCode == 401 && requireAuth) {
      debugPrint('ACCESS TOKEN EXPIRED → REFRESHING');

      final newToken = await AuthService.refreshToken();
      if (newToken == null) {
        throw UnauthenticatedException();
      }

      headers['Authorization'] = 'Bearer $newToken';
      response = await http.get(url, headers: headers);
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception('API error ${response.statusCode}');
  }
}



class UnauthenticatedException implements Exception {}
