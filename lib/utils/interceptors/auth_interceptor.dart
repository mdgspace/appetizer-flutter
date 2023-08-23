import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthInterceptor extends Interceptor {
  ValueGetter<FutureOr<String?>>? getToken;

  AuthInterceptor({this.getToken});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await getToken?.call();
    if (token != null) {
      final headerOptions = options.copyWith(
        headers: {'Authorization': 'Token $token'},
      );

      return super.onRequest(headerOptions, handler);
    }

    return super.onRequest(options, handler);
  }
}
