import 'package:appetizer_revamp_parts/services/analytics_service.dart';
import 'package:appetizer_revamp_parts/services/api/coupon_api.dart';
import 'package:appetizer_revamp_parts/services/api/feedback_api.dart';
import 'package:appetizer_revamp_parts/services/api/leave_api.dart';
import 'package:appetizer_revamp_parts/services/api/menu_api.dart';
import 'package:appetizer_revamp_parts/services/api/multimessing_api.dart';
import 'package:appetizer_revamp_parts/services/api/transaction_api.dart';
import 'package:appetizer_revamp_parts/services/api/user_api.dart';
import 'package:appetizer_revamp_parts/services/api/version_check_api.dart';
import 'package:appetizer_revamp_parts/services/dialog_service.dart';
import 'package:appetizer_revamp_parts/services/local_storage_service.dart';
import 'package:appetizer_revamp_parts/services/package_info_service.dart';
import 'package:appetizer_revamp_parts/services/push_notification_service.dart';
import 'package:appetizer_revamp_parts/services/remote_config_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => CouponApi());
  locator.registerLazySingleton(() => FeedbackApi());
  locator.registerLazySingleton(() => LeaveApi());
  locator.registerLazySingleton(() => MenuApi());
  locator.registerLazySingleton(() => MultimessingApi());
  locator.registerLazySingleton(() => TransactionApi());
  locator.registerLazySingleton(() => UserApi());
  locator.registerLazySingleton(() => VersionCheckApi());

  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => DialogService());

  var remoteConfigService = await RemoteConfigService.getInstance();
  locator.registerSingleton<RemoteConfigService>(remoteConfigService);

  var localStorageService = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorageService);

  var packageInfoService = await PackageInfoService.getInstance();
  locator.registerSingleton<PackageInfoService>(packageInfoService);
}
