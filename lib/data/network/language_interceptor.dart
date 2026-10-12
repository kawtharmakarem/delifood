import 'package:dio/dio.dart';
import '/app/app_preferences.dart';

class LanguageInterceptor extends Interceptor {
  final AppPreferences _appPreferences;
  LanguageInterceptor(this._appPreferences);
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    //super.onRequest(options, handler);
    final language = await _appPreferences.getAppLanguage();
    options.headers['language'] = language;
    handler.next(options);
  }
}
