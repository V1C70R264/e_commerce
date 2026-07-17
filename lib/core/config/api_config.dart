// lib/core/config/api_config.dart
import 'dart:io' show Platform;

class ApiConfig {
  static String get baseUrl {
    if (Platform.isAndroid) {
      // 10.0.2.2 = emulator's alias for host machine
      return const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'http://192.168.1.184:8000/api/v1',
      );
    }
    return const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://localhost:8000/api/v1',
    );
  }
}