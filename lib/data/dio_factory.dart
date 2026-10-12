import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '/app/app_preferences.dart';
import '/app/constants.dart';
import '/data/network/auth_interceptors.dart';
import '/data/network/language_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);
  Dio? _dio;
  Future<Dio> getDio() async {
    if (_dio != null) {
      return _dio!;
    }
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: Duration(seconds: 20),
        receiveTimeout: Duration(seconds: 20),
        sendTimeout: Duration(seconds: 20),
        headers: {
          Headers.acceptHeader: Headers.jsonContentType,
          Headers.contentTypeHeader: Headers.jsonContentType,
        },
      ),
    );

    _dio!.interceptors.add(AuthInterceptors(_appPreferences));
    _dio!.interceptors.add(LanguageInterceptor(_appPreferences));
    if (kDebugMode) {
      _dio!.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
        ),
      );
    }

    return _dio!;
  }
}
