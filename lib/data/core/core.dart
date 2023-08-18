import 'dart:developer';

import 'package:appetizer/domain/core/core.dart';

class AppCoreModuleImpl implements AppCoreModule<void> {
  @override
  void bootDown() {
    log('[AppCoreModule.onBootDown]');

    for (final amenity in AppCoreModule.bootUpProcess) {
      amenity.bootDown();
    }
  }

  @override
  Future<void> bootUp() async {
    log('[AppCoreModule.bootUp]');

    for (final amenity in AppCoreModule.bootUpProcess) {
      await amenity.bootUp();
      amenity.onBootUp();
    }
  }

  @override
  void onBootUp() {
    log('[AppCoreModule.onBootUp]');
  }
}
