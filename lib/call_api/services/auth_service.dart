import 'dart:convert';
import 'package:http/http.dart' as http;

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
      headers: {
        "Content-Type" : "application/json",
      },
      body: jsonEncode({
        'email' : email,
        'password' : password,
        }),
    );

    if (reponse.statusCode == 200 || reponse.statusCode == 201) {
      print("Register Success: ${reponse.body}");
    }
    else {
      print("Register failed: ${reponse.body}");
      throw Exception("Register failed");
    }
  }

  // auth login
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/auth/login");

    final reponse = await http.post(
      url,
      headers: {"Content-Type" : "application/json"},
      body: jsonEncode({
        "email" : email,
        "password" : password,
      }),
    );

    if (reponse.statusCode == 200) {
      return jsonDecode(reponse.body);
    }else {
      throw Exception(reponse.body);
    }
  }
}