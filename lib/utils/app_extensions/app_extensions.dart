import 'package:appetizer/data/core/router/router.dart';
import 'package:appetizer/domain/core/router/router.dart';
import 'package:appetizer/domain/core/theme/theme.dart';
import 'package:flutter/material.dart';

class BaseApp {
  BaseApp._();

  static final AppRouterImpl router = AppRouter.instance;
  static BuildContext? get currentContext => router.navigatorKey.currentContext;
  static final theme = AppThemeBox.instance;
}
