import 'package:e_commerce/core/constants/api_paths.dart';
import 'package:e_commerce/core/network/api_client.dart';

/// Placeholder for future Google sign-in integration with Django.
class GoogleAuthService {
  final ApiClient apiClient;

  GoogleAuthService(this.apiClient);

  Future<Map<String, dynamic>> signIn() async {
    throw UnimplementedError(
      'Google sign-in is not configured. Set up GoogleSignIn and ${ApiPaths.googlesignin}.',
    );
  }
}
