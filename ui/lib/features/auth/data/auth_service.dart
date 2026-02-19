import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/api_constants.dart';

class AuthService {
  // Login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'Email': email,
          'Password': password,
        },
      ).timeout(const Duration(seconds: 15));

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['result'] == true) {
        if (data['token'] == null) {
          return {'success': false, 'message': 'Invalid response from server (No Token)'};
        }
        
        // Save Token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        
        // Save User Data (Optional, but good for profile)
        if (data['data'] != null) {
             await prefs.setString('user_data', json.encode(data['data']));
        }

        return {'success': true, 'data': data};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Login failed'
        };
      }
    } on http.ClientException catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Logout method
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      try {
        await http.post(
          Uri.parse(ApiConstants.logout),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
      } catch (e) {
        // Prepare for local logout even if API fails
      }
    }

    await prefs.clear();
  }
}
