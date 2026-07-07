// lib/features/auth/google_auth_service.dart
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/network/api_client.dart';

class GoogleAuthService {
  final ApiClient apiClient;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    // serverClientId is REQUIRED on Android to get an idToken usable server-side
    serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
  );

  GoogleAuthService(this.apiClient);

  Future<Map<String, dynamic>> signIn() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Sign-in cancelled by user');
    }

    final googleAuth = await googleUser.authentication;
    final idToken = googleAuth.idToken;
    if (idToken == null) {
      throw Exception('Failed to obtain Google ID token');
    }

    final response = await apiClient.dio.post(
      '/auth/google/',
      data: {'id_token': idToken},
    );

    return response.data;
  }
}