// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class Authstorage {
//   static const _accessTokenKey = 'accessToken';
//   static const _refreshTokenKey = 'refreshToken';
//   static const _emailKey = 'email';

//   static Future<void> saveLoginData({
//     required String accessToken,
//     required String refreshToken,
//     required String email,
//     required String? avatarUrl,
//   }) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_accessTokenKey, accessToken);
//     await prefs.setString(_refreshTokenKey, refreshToken);
//     await prefs.setString(_emailKey, email);
//     if (avatarUrl != null) {
//       await prefs.setString('avatarUrl', avatarUrl);
//     }
//   }

//   //lấy avatarUrl từ BE
//   static Future<String?> getAvatar() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('avatarUrl');
//   }

//   //save access token khi refresh
//   static Future<void> saveAccessToken(String accessToken) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_accessTokenKey, accessToken);
//   }

//   //refresh token
//   static Future<String?> getRefreshToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_refreshTokenKey);
//   }

//   //access token
//   static Future<String?> getAccessToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_accessTokenKey);
//   }

//   static Future<bool> isLoggedIn() async {
//     return await getAccessToken() != null;
//   }

//   static Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//   }

//   //get current user
//   static Future<void> saveCurrentUser(Map<String, dynamic> user) async {
//   await storage.write(
//     key: 'currentUser',
//     value: jsonEncode(user),
//   );
// }

// static Future<Map<String, dynamic>?> getCurrentUserRaw() async {
//   final jsonString = await storage.read(key: 'currentUser');
//   if (jsonString == null) return null;
//   return jsonDecode(jsonString);
// }

// }


import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Authstorage {
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';
  static const _emailKey = 'email';
  static const _currentUserKey = 'currentUser';
  static const _avatarKey = 'avatarUrl';

  // SAVE LOGIN
  static Future<void> saveLoginData({
    required String accessToken,
    required String refreshToken,
    required String email,
    String? avatarUrl,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setString(_emailKey, email);
    if (avatarUrl != null) {
      await prefs.setString(_avatarKey, avatarUrl);
    }
  }

  // SAVE CURRENT USER
  static Future<void> saveCurrentUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, jsonEncode(user));
  }

  // GET CURRENT USER (RAW JSON)
  static Future<Map<String, dynamic>?> getCurrentUserRaw() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_currentUserKey);
    if (jsonString == null) return null;
    return jsonDecode(jsonString);
  }

  // AVATAR
  static Future<String?> getAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_avatarKey);
  }

  // TOKENS
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<void> saveAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
  }

  static Future<bool> isLoggedIn() async {
    return await getAccessToken() != null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

