import 'package:appetizer/data/core/theme/theme.dart';
import 'package:appetizer/domain/core/core.dart';
import 'package:flutter/material.dart';

part 'policies/colors.dart';

abstract class AppThemeBox implements AppCoreModule<void> {
  static final AppThemeBox instance = AppThemeBoxImpl();

  AppThemeColors get colors;
}
