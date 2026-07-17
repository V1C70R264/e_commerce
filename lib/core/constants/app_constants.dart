import '../config/api_config.dart';

class AppConstants {
  // App Info
  static const String appName = 'Soko Mkononi';
  static const String appVersion = '1.0.0';

  // API Constants — override with --dart-define=API_BASE_URL=http://host:8000/api/v1
  static String get baseUrl => ApiConfig.baseUrl;
  static const int apiTimeout = 30000; // 30 seconds

  // Shared Preferences Keys
  static const String languageKey = 'selected_language';
  static const String userTokenKey = 'user_token';
  static const String userIdKey = 'user_id';

  // Animation Durations
  static const Duration splashDuration = Duration(milliseconds: 1500);
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);

  // Supported Languages
  static const List<String> supportedLanguages = ['en', 'sw'];
  static const String defaultLanguage = 'en';
}
