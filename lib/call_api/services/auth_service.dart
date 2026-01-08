import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'authstorage.dart';

class AuthService {
  static const String baseUrl = "https://movie-server-mlom.onrender.com";

  //auth register
  static Future<void> register({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/auth/register");

    final reponse = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (reponse.statusCode == 200 || reponse.statusCode == 201) {
      print("Register Success: ${reponse.body}");
    } else {
      print("Register failed: ${reponse.body}");
      throw Exception("Register failed");
    }
  }

  // auth login
  static Future<void> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/auth/login");

    final reponse = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (reponse.statusCode == 200) {
      final data = jsonDecode(reponse.body);

      // save token nhớ đăng nhập
      await Authstorage.saveLoginData(
        accessToken: data['accessToken'],
        refreshToken: data['refreshToken'],
        userId: data['user']['id'],
        email: data['user']['email'],
      );

      debugPrint('LOGIN SUCCESS + TOKEN SAVED');
    } else {
      throw Exception(reponse.body);
    }
  }

  static Future<void> logout() async {
    await Authstorage.logout();
  }

  static Future<String?> getAccessToken() async {
    return await Authstorage.getAccessToken();
  }

  // refresh token
  static Future<String?> refreshToken() async {
    final refreshToken = await Authstorage.getRefreshToken();
    if (refreshToken == null) return null;

    final response = await http.post(
      Uri.parse('$baseUrl/auth/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['accessToken'];

      await Authstorage.saveAccessToken(newAccessToken);
      debugPrint('ACCESS TOKEN REFRESHED');

      return newAccessToken;
    }

    return null;
  }
}
