import 'dart:collection';

import 'package:appetizer/data/core/core.dart';
import 'package:appetizer/domain/core/theme/theme.dart';
import 'package:appetizer/utils/booters/app_booter_bloc.dart';

abstract class AppCoreModule<T> implements Booter<T> {
  static final AppCoreModule instance = AppCoreModuleImpl();

  static final bootUpProcess = UnmodifiableListView(<AppCoreModule>[
    AppThemeBox.instance,
  ]);
}
