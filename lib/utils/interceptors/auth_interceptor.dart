import 'dart:async';
import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/local/local_storage_service.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/utils/app_extensions/app_extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthInterceptor extends Interceptor {
  ValueGetter<FutureOr<String?>>? getToken;

  AuthInterceptor({
    this.getToken,
  });

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

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      LocalStorageService.setValue(key: AppConstants.LOGGED_IN, value: false);
      LocalStorageService.setValue(key: AppConstants.AUTH_TOKEN, value: null);
      if (BaseApp.currentContext != null) {
        const snackBar =
            SnackBar(content: Text('User is inactive or unauthorized!'));
        ScaffoldMessenger.of(BaseApp.currentContext!).showSnackBar(snackBar);
      }
      BaseApp.currentContext
          ?.read<AppBloc>()
          .add(const NavigateToLoginScreen());
    } else {
      handler.next(err);
    }
  }
}
