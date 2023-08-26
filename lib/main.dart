import 'package:appetizer/presentation/app/app.dart';
import 'package:appetizer/utils/local_storage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const AppetizerApp(),
    ),
  );
}
