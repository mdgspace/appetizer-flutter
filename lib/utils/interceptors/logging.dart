import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(
      'REQUEST[${options.method}] Body: ${options.data} => PATH: ${options.uri}',
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] Body: ${response.data} => PATH: ${response.requestOptions.uri}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      'ERROR[${err.response?.statusCode}] Body: ${err.response?.data} => PATH: ${err.requestOptions.uri}',
    );
    return super.onError(err, handler);
  }
}
