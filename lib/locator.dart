import 'package:appetizer/services/api/feedback.dart';
import 'package:appetizer/services/api/leave.dart';
import 'package:appetizer/services/api/menu.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/services/api/transaction.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/api/version_check.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FeedbackApi());
  locator.registerLazySingleton(() => LeaveApi());
  locator.registerLazySingleton(() => MenuApi());
  locator.registerLazySingleton(() => MultimessingApi());
  locator.registerLazySingleton(() => TransactionApi());
  locator.registerLazySingleton(() => UserApi());
  locator.registerLazySingleton(() => VersionCheckApi());
}
