import 'package:dio/dio.dart';
import '/app/app_preferences.dart';

class AuthInterceptors extends Interceptor {
  final AppPreferences _appPreferences;
  AuthInterceptors(this._appPreferences);
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // super.onRequest(options, handler);
    final token = await _appPreferences.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = "Bearer $token";
    }
    handler.next(options);
  }
}
