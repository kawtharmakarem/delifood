import 'dart:io';

import 'package:dio/dio.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else {
      return Failure.fromCode(ResponseCode.unKnown);
    }
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Failure.fromCode(ResponseCode.connectTimeOut);
      case DioExceptionType.sendTimeout:
        return Failure.fromCode(ResponseCode.sendTimeout);
      case DioExceptionType.receiveTimeout:
        return Failure.fromCode(ResponseCode.receiveTimeout);
      case DioExceptionType.badCertificate:
        return Failure.fromCode(ResponseCode.badCertificate);
      case DioExceptionType.badResponse:
        //todo later
        if (error.response != null) {
          final statusCode = error.response?.statusCode ?? ResponseCode.unKnown;
          final message = _extractMessage(error.response!);
          // final message =
          //     error.response?.data['message'] ??
          //     error.response?.statusMessage ??
          //     ResponseMessage.unKnown;
          return Failure(code: statusCode, message: message);
        }
        return Failure.fromCode(ResponseCode.unKnown);
      case DioExceptionType.cancel:
        return Failure.fromCode(ResponseCode.cancel);
      case DioExceptionType.connectionError:
        return Failure.fromCode(ResponseCode.noInternetConnection);
      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return Failure.fromCode(ResponseCode.noInternetConnection);
        }
        return Failure.fromCode(ResponseCode.unKnown);
      case DioExceptionType.transformTimeout:
        return Failure.fromCode(ResponseCode.transformTimeout);
    }
  }

  static String _extractMessage(Response<dynamic> response) {
    final data = response.data;
    if (data is Map) {
      return data['message'] ?? data['error'] ?? ResponseMessage.unKnown;
    } else {
      return ResponseMessage.unKnown;
    }
  }
}

class Failure {
  final int code;
  final String message;

  Failure({required this.code, required this.message});
  factory Failure.fromCode(int code) {
    switch (code) {
      case ResponseCode.success:
        return Failure(
          code: ResponseCode.success,
          message: ResponseMessage.success,
        );
      case ResponseCode.created:
        return Failure(
          code: ResponseCode.created,
          message: ResponseMessage.created,
        );
      case ResponseCode.noContent:
        return Failure(
          code: ResponseCode.noContent,
          message: ResponseMessage.noContent,
        );
      //Http error client
      case ResponseCode.badRequest:
        return Failure(
          code: ResponseCode.badRequest,
          message: ResponseMessage.badRequest,
        );
      case ResponseCode.unAuthorized:
        return Failure(
          code: ResponseCode.unAuthorized,
          message: ResponseMessage.unAuthorized,
        );
      case ResponseCode.forbidden:
        return Failure(
          code: ResponseCode.forbidden,
          message: ResponseMessage.forbidden,
        );
      case ResponseCode.notFound:
        return Failure(
          code: ResponseCode.notFound,
          message: ResponseMessage.notFound,
        );
      case ResponseCode.methodNotAllowed:
        return Failure(
          code: ResponseCode.methodNotAllowed,
          message: ResponseMessage.methodNotAllowed,
        );
      case ResponseCode.unprocessableEntity:
        return Failure(
          code: ResponseCode.unprocessableEntity,
          message: ResponseMessage.unprocessableEntity,
        );
      case ResponseCode.tooManyRequests:
        return Failure(
          code: ResponseCode.tooManyRequests,
          message: ResponseMessage.tooManyRequests,
        );
      case ResponseCode.internalServerError:
        return Failure(
          code: ResponseCode.internalServerError,
          message: ResponseMessage.internalServerError,
        );
      case ResponseCode.serviceUnavailable:
        return Failure(
          code: ResponseCode.serviceUnavailable,
          message: ResponseMessage.serviceUnavailable,
        );
      case ResponseCode.gatewayTimeout:
        return Failure(
          code: ResponseCode.gatewayTimeout,
          message: ResponseMessage.gatewayTimeout,
        );
      case ResponseCode.connectTimeOut:
        return Failure(
          code: ResponseCode.connectTimeOut,
          message: ResponseMessage.connectTimeOut,
        );
      case ResponseCode.cancel:
        return Failure(
          code: ResponseCode.cancel,
          message: ResponseMessage.cancel,
        );
      case ResponseCode.receiveTimeout:
        return Failure(
          code: ResponseCode.receiveTimeout,
          message: ResponseMessage.receiveTimeout,
        );
      case ResponseCode.sendTimeout:
        return Failure(
          code: ResponseCode.sendTimeout,
          message: ResponseMessage.sendTimeout,
        );
      case ResponseCode.cacheError:
        return Failure(
          code: ResponseCode.cacheError,
          message: ResponseMessage.cacheError,
        );
      case ResponseCode.noInternetConnection:
        return Failure(
          code: ResponseCode.noInternetConnection,
          message: ResponseMessage.noInternetConnection,
        );
      case ResponseCode.transformTimeout:
        return Failure(
          code: ResponseCode.transformTimeout,
          message: ResponseMessage.transformTimeout,
        );
      case ResponseCode.badCertificate:
        return Failure(
          code: ResponseCode.badCertificate,
          message: ResponseMessage.badCertificate,
        );
      case ResponseCode.unKnown:
        return Failure(
          code: ResponseCode.unKnown,
          message: ResponseMessage.unKnown,
        );
      default:
        return Failure(
          code: ResponseCode.unKnown,
          message: ResponseMessage.unKnown,
        );
    }
  }
}

class ResponseCode {
  ResponseCode._();
  //Http Success Response
  static const int success = 200; //Request completed successfully
  static const int created = 201; //Resource created successfully
  static const int noContent =
      204; //Request succeeded but there is no content to return

  //Http client errors
  static const int badRequest =
      400; //The request contains invalid data or parameters
  static const int unAuthorized =
      401; //authentication is required or token is invalid

  static const int forbidden =
      403; //user is authenticated but doesn't have permission

  static const int notFound = 404; //Requested resource was not found
  static const int methodNotAllowed = 405; //Request method is not allowed
  static const int unprocessableEntity =
      422; //the server cannot process the request because of invalid input
  static const int tooManyRequests = 429; //Too many requests in a short time
  static const int internalServerError =
      500; //Something went wrong on the server
  static const int serviceUnavailable =
      503; //the server is temporarily unavailable
  static const int gatewayTimeout =
      504; //The server didn't receive a response from another server in time
  //local status code
  static const int connectTimeOut =
      -1; //Connection timeout while establishing connection
  static const int cancel =
      -2; //Request was cancelled by the user or the application
  static const int receiveTimeout = -3; //Timeout while waiting to receive data
  static const int sendTimeout = -4; //timeout while sending request data
  static const int cacheError = -5; //Error while reading or waiting local cache
  static const int noInternetConnection =
      -6; //Device has no internet connection
  static const int unKnown = -7; //Unknown or unexpected error
  static const int transformTimeout = -9; //dio took a long time in parsing json
  static const int badCertificate = -10; //Certificate expired
}

class ResponseMessage {
  ResponseMessage._();
  //Http success messages
  static const String success = "Request completed successfully";
  static const String created = "Resource created successfully";
  static const String noContent =
      "Request succeeded but there is no content to return";

  //Http client errors message
  static const String badRequest =
      "The request contains invalid data or parameters";
  static const String unAuthorized =
      "authentication is required or token is invalid";

  static const String forbidden =
      "user is authenticated but doesn't have permission";

  static const String notFound = "Requested resource was not found";
  static const String methodNotAllowed = "Request method is not allowed";
  static const String unprocessableEntity =
      "the server cannot process the request because of invalid input";
  static const String tooManyRequests = "Too many requests in a short time";
  static const String internalServerError =
      "Something went wrong on the server";
  static const String serviceUnavailable =
      "the server is temporarily unavailable";
  static const String gatewayTimeout =
      "The server didn't receive a response from another server in time";
  //local status code
  static const String connectTimeOut =
      "Connection timeout while establishing connection";
  static const String cancel =
      "Request was cancelled by the user or the application";
  static const String receiveTimeout = "Timeout while waiting to receive data";
  static const String sendTimeout = "timeout while sending request data";
  static const String cacheError = "Error while reading or waiting local cache";
  static const String noInternetConnection =
      "Device has no internet connection";
  static const String unKnown = "Unknown or unexpected error";
  static const String transformTimeout = "dio took a long time in parsing json";
  static const String badCertificate = "Certificate expired";
}
