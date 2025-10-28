import 'dart:convert';
import 'package:e_commerce/data/models/user_model.dart';
import 'package:e_commerce/core/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserRemoteDatasource {
  Future<UserModel> fetchUserProfile();
  Future<bool> register(
      {required String username,
      required String email,
      required String password,
      required String firstName,
      required String lastName});
  Future<bool> login({required String email, required String password});
  Future<void> logout();
  // Add other methods as needed
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  // Django server URLs
  static final String apiBaseUrl = AppConstants.baseUrl.endsWith('/')
      ? AppConstants.baseUrl
      : '${AppConstants.baseUrl}/';
  static final String authBaseUrl = '${apiBaseUrl}auth/';

  // Alternative: Use 10.0.2.2 for Android emulator testing
  // static const String baseUrl = 'http://10.0.2.2:8000/api/';

  @override
  Future<UserModel> fetchUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    if (token == null) {
      throw Exception('No access token found');
    }
    var response = await http.get(
      Uri.parse('${apiBaseUrl}user/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  @override
  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('${authBaseUrl}register/'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'username': username,
              'email': email,
              'password': password,
              'first_name': firstName,
              'last_name': lastName,
            }),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 201) {
        return true;
      }
      // Log server error details to help debugging 400s
      // ignore: avoid_print
      print('Register failed [${response.statusCode}]: ${response.body}');
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('${authBaseUrl}login/'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', data['access']);
        await prefs.setString('refresh_token', data['refresh']);
        return true;
      } else {
        // ignore: avoid_print
        print('Login failed [${response.statusCode}]: ${response.body}');
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
    } catch (e) {
      // Optionally handle error
    }
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    return token != null && token.isNotEmpty;
  }

  // Add other methods as needed
}
