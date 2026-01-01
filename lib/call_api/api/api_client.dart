import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'api_endpoints.dart';

class ApiClient {
  Future<dynamic> get(String endpoints) async {
    final url = Uri.parse(ApiEndpoints.baseUrl + endpoints);
    debugPrint('call api: $url');

    final response = await http.get(url);

    debugPrint('STATUS CODE: ${response.statusCode}');
    

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('API error ${response.statusCode}');
    }
  }
}
