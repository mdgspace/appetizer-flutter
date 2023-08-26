import 'package:appetizer/presentation/app/app.dart';
import 'package:appetizer/utils/local_storage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  // TODO: fix android 12 splash
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await LocalStorage.init();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const AppetizerApp(),
    ),
  );
}
