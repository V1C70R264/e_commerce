import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DjangoAuthService {
  // Django server URL - use your computer's IP address for device testing
  static const String baseUrl = 'http://192.168.43.139:8000/api/';
  
  // Alternative: Use 10.0.2.2 for Android emulator testing
  // static const String baseUrl = 'http://10.0.2.2:8000/api/';
  
  // Register a new user
  static Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      print('Attempting to register user: $username');
      print('Using URL: ${baseUrl}register/');
      
      final response = await http.post(
        Uri.parse('${baseUrl}register/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10));

      print('Register response status: ${response.statusCode}');
      print('Register response body: ${response.body}');

      if (response.statusCode == 201) {
        print('Registration successful!');
        return true;
      } else {
        print('Registration failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  // Login user
  static Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      print('Attempting to login user: $username');
      print('Using URL: ${baseUrl}login/');
      
      final response = await http.post(
        Uri.parse('${baseUrl}login/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10));

      print('Login response status: ${response.statusCode}');
      print('Login response body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the response to get tokens
        final data = json.decode(response.body);
        
        // Save tokens to local storage
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', data['access']);
        await prefs.setString('refresh_token', data['refresh']);
        
        print('Login successful! Tokens saved.');
        return true;
      } else {
        print('Login failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      return token != null;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  // Logout user
  static Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
      print('User logged out successfully');
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  // Test connection to Django server
  static Future<bool> testConnection() async {
    try {
      print('Testing connection to Django server...');
      print('URL: ${baseUrl}');
      
      final response = await http.get(
        Uri.parse('${baseUrl}'),
      ).timeout(const Duration(seconds: 5));

      print('Connection test status: ${response.statusCode}');
      print('Connection test response: ${response.body}');
      
      return response.statusCode == 200;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }

  // Get current base URL for debugging
  static String getCurrentBaseUrl() {
    return baseUrl;
  }
} 