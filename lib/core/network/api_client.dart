import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../constants/api_paths.dart';
import '../storage/token_storage.dart';

class ApiClient {
  final Dio dio;
  final TokenStorage tokenStorage;

  ApiClient({TokenStorage? storage})
      : tokenStorage = storage ?? TokenStorage(),
        dio = Dio(BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Accept': 'application/json'},
        )) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenStorage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            final refreshed = await _tryRefreshToken();
            if (refreshed) {
              final opts = error.requestOptions;
              final token = await tokenStorage.getAccessToken();
              opts.headers['Authorization'] = 'Bearer $token';
              final clonedResponse = await dio.fetch(opts);
              return handler.resolve(clonedResponse);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<bool> _tryRefreshToken() async {
    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final response = await Dio(BaseOptions(baseUrl: ApiConfig.baseUrl)).post(
        ApiPaths.tokenRefresh,
        data: {'refresh': refreshToken},
      );
      final access = response.data['access'] as String?;
      if (access == null) return false;
      await tokenStorage.saveTokens(
        access: access,
        refresh: refreshToken,
      );
      return true;
    } catch (_) {
      await tokenStorage.clearTokens();
      return false;
    }
  }
}
