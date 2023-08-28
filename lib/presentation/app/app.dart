import 'package:appetizer/data/services/remote/api_service.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/utils/app_extensions/app_extensions.dart';
import 'package:appetizer/utils/interceptors/auth_interceptor.dart';
import 'package:appetizer/utils/interceptors/logging.dart';
import 'package:auto_route/auto_route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sentry_dio/sentry_dio.dart';

class AppetizerApp extends StatefulWidget {
  const AppetizerApp({super.key});

  @override
  State<AppetizerApp> createState() => _AppetizerAppState();
}

class _AppetizerAppState extends State<AppetizerApp> {
  late final ApiService apiService;

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () => FlutterNativeSplash.remove(),
    );
    apiService = _getApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: const [],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: "Appetizer",
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            routerDelegate: AutoRouterDelegate(BaseApp.router),
            routeInformationParser: BaseApp.router.defaultRouteParser(),
            // TODO: add theme
          );
        },
      ),
    );
  }

  ApiService _getApiService() {
    return ApiService(
      Dio(
        BaseOptions(
          headers: {'Content-Type': 'application/json'},
        ),
      )
        ..interceptors.addAll(
          [
            AuthInterceptor(), // TODO: wirein get token method
            Logging(),
          ],
        )
        ..addSentry(),
    );
  }
}
