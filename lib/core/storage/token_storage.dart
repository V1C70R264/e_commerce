import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _storage;

  TokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await _storage.write(key: _accessTokenKey, value: access);
    await _storage.write(key: _refreshTokenKey, value: refresh);
  }

  Future<String?> getAccessToken() {
    return _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() {
    return _storage.read(key: _refreshTokenKey);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
