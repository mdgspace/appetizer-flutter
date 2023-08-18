import 'dart:developer';

import 'package:appetizer/domain/core/theme/theme.dart';

class AppThemeBoxImpl implements AppThemeBox {
  @override
  AppThemeColors get colors => throw UnimplementedError();

  @override
  void bootDown() {
    log('AppThemeBox.bootDown');
  }

  @override
  Future<void> bootUp() async {
    log('[AppThemeBox.bootUp]');
  }

  @override
  void onBootUp() {
    log('[AppThemeBox.onBootUp]');
  }
}
