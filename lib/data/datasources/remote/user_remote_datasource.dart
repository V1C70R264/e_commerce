import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_commerce/core/constants/api_paths.dart';
import 'package:e_commerce/core/network/api_client.dart';
import 'package:e_commerce/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDatasource {
  Future<UserModel> fetchUserProfile();
  Future<UserModel> updateProfileImage(File image);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final ApiClient apiClient;

  UserRemoteDatasourceImpl({ApiClient? apiClient})
      : apiClient = apiClient ?? ApiClient();

  @override
  Future<UserModel> fetchUserProfile() async {
    final token = await apiClient.tokenStorage.getAccessToken();
    if (token == null) {
      throw Exception('No access token found');
    }

    try {
      final response = await apiClient.dio.get(ApiPaths.profile);
      return _parseUserResponse(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Session expired. Please log in again.');
      }
      throw Exception(_errorMessage(e, 'Failed to load user profile'));
    }
  }

  @override
  Future<UserModel> updateProfileImage(File image) async {
    final token = await apiClient.tokenStorage.getAccessToken();
    if (token == null) {
      throw Exception('No access token found');
    }

    final uri = Uri.parse('${apiClient.dio.options.baseUrl}${ApiPaths.profile}');
    final request = http.MultipartRequest('PATCH', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(
        await http.MultipartFile.fromPath('profile_image', image.path),
      );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return _parseUserResponse(body);
    }

    throw Exception('Failed to upload profile image');
  }

  UserModel _parseUserResponse(dynamic body) {
    Map<String, dynamic> userJson;
    if (body is Map<String, dynamic>) {
      if (body.containsKey('user') && body['user'] is Map<String, dynamic>) {
        userJson = body['user'] as Map<String, dynamic>;
      } else if (body.containsKey('data') &&
          body['data'] is Map<String, dynamic>) {
        userJson = body['data'] as Map<String, dynamic>;
      } else {
        userJson = body;
      }
    } else {
      throw Exception('Failed to load user profile');
    }
    return UserModel.fromJson(userJson);
  }

  String _errorMessage(DioException e, String fallback) {
    final data = e.response?.data;
    if (data is Map<String, dynamic> && data['detail'] != null) {
      return data['detail'].toString();
    }
    return fallback;
  }
}
