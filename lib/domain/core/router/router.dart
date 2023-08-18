import 'package:appetizer/data/core/router/router.dart';
import 'package:appetizer/domain/core/core.dart';

abstract class AppRouter<I> implements AppCoreModule<void> {
  static final AppRouterImpl instance = AppRouterImpl();

  void navigateToPage(I router);
}
