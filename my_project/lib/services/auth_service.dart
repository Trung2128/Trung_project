import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const String _baseUrl = 'https://dummyjson.com';

  static Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'expiresInMins': 30,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> register(String email, String password, String name) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/users/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': name,
          'email': email,
          'password': password,
        }),
      );

      return (response.statusCode == 200 || response.statusCode == 201);
    } catch (e) {
      return false;
    }
  }
}