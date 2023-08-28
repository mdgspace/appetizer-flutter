import 'package:appetizer/data/services/remote/api_service.dart';
import 'package:appetizer/domain/repositories/coupon_repository.dart';
import 'package:appetizer/domain/repositories/feedback_repository.dart';
import 'package:appetizer/domain/repositories/leave_repository.dart';
import 'package:appetizer/domain/repositories/menu_repository.dart';
import 'package:appetizer/domain/repositories/transaction_repositroy.dart';
import 'package:appetizer/domain/repositories/user_repository.dart';
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
      providers: [
        RepositoryProvider<CouponRepository>(create: (context) => CouponRepository(apiService)),
        RepositoryProvider<FeedbackRepository>(create: (context) => FeedbackRepository(apiService)),
        RepositoryProvider<LeaveRepository>(create: (context) => LeaveRepository(apiService)),
        RepositoryProvider<MenuRepository>(create: (context) => MenuRepository(apiService)),
        RepositoryProvider<TransactionRepository>(create: (context) => TransactionRepository(apiService)),
        RepositoryProvider<UserRepository>(create: (context) => UserRepository(apiService)),
      ],
      child: BlocProvider(
        create: (context) => AppBloc(repo: context.read<UserRepository>()),
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
