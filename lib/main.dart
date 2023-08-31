import 'package:appetizer/data/constants/env_config.dart';
import 'package:appetizer/data/services/local/local_storage_service.dart';
import 'package:appetizer/presentation/app/app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  // TODO: fix android 12 splash
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await LocalStorageService.init();
  FlutterNativeSplash.remove();

  await SentryFlutter.init(
    (options) {
      options
        ..dsn = EnvironmentConfig.SENTRY_DSN
        ..tracesSampleRate = 1.0
        ..reportPackages = true
        ..debug = kDebugMode;
    },
    appRunner: () => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const AppetizerApp(),
      ),
    ),
  );
}
