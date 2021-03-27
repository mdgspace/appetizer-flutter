import 'package:appetizer/services/analytics_service.dart';
import 'package:appetizer/services/api/feedback_api.dart';
import 'package:appetizer/services/api/leave_api.dart';
import 'package:appetizer/services/api/menu_api.dart';
import 'package:appetizer/services/api/multimessing_api.dart';
import 'package:appetizer/services/api/transaction_api.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/services/api/version_check_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/services/local_storage_service.dart';
import 'package:appetizer/services/push_notification_service.dart';
import 'package:appetizer/services/remote_config_service.dart';
import 'package:appetizer/viewmodels/faq/faq_viewmodel.dart';
import 'package:appetizer/viewmodels/feedback/new_feedback_viewmodel.dart';
import 'package:appetizer/viewmodels/feedback/user_feedback_viewmodel.dart';
import 'package:appetizer/viewmodels/home_viewmodel.dart';
import 'package:appetizer/viewmodels/leaves/leave_status_card_viewmodel.dart';
import 'package:appetizer/viewmodels/leaves/leave_timeline_viewmodel.dart';
import 'package:appetizer/viewmodels/leaves/my_leaves_viewmodel.dart';
import 'package:appetizer/viewmodels/login/login_viewmodel.dart';
import 'package:appetizer/viewmodels/menu/other_menu_card_viewmodel.dart';
import 'package:appetizer/viewmodels/menu/other_menu_viewmodel.dart';
import 'package:appetizer/viewmodels/menu/your_menu_card_viewmodel.dart';
import 'package:appetizer/viewmodels/menu/your_menu_viewmodel.dart';
import 'package:appetizer/viewmodels/multimessing/qr_genrator_viewmodel.dart';
import 'package:appetizer/viewmodels/multimessing/switchable_meals_viewmodel.dart';
import 'package:appetizer/viewmodels/notifications/notifications_viewmodel.dart';
import 'package:appetizer/viewmodels/password/forgot_password_viewmodel.dart';
import 'package:appetizer/viewmodels/password/new_password_viewmodel.dart';
import 'package:appetizer/viewmodels/password/update_password_viewmodel.dart';
import 'package:appetizer/viewmodels/rebates/my_rebates_viewmodel.dart';
import 'package:appetizer/viewmodels/rebates/rebate_history_viewmodel.dart';
import 'package:appetizer/viewmodels/settings/edit_profile_viewmodel.dart';
import 'package:appetizer/viewmodels/settings/settings_viewmodel.dart';
import 'package:appetizer/viewmodels/startup_viewmodel.dart';
import 'package:appetizer/viewmodels/switches/confirm_switch_popup_viewmodel.dart';
import 'package:appetizer/viewmodels/switches/my_switches_viewmodel.dart';
import 'package:appetizer/viewmodels/switches/switch_status_card_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
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
  locator.registerSingleton(remoteConfigService);

  var localStorageService = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorageService);

  locator.registerFactory(() => StartUpViewModel());
  locator.registerFactory(() => FaqViewModel());
  locator.registerFactory(() => NewFeedbackViewModel());
  locator.registerFactory(() => UserFeedbackViewModel());
  locator.registerFactory(() => LeaveStatusCardViewModel());
  locator.registerFactory(() => LeaveTimelineViewModel());
  locator.registerFactory(() => MyLeavesViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => OtherMenuViewModel());
  locator.registerFactory(() => YourMenuViewModel());
  locator.registerFactory(() => QRGeneratorViewModel());
  locator.registerFactory(() => SwitchableMealsViewModel());
  locator.registerFactory(() => NotificationsViewModel());
  locator.registerFactory(() => ForgotPasswordViewModel());
  locator.registerFactory(() => NewPasswordViewModel());
  locator.registerFactory(() => UpdatePasswordViewModel());
  locator.registerFactory(() => MyRebatesViewModel());
  locator.registerFactory(() => RebateHistoryViewModel());
  locator.registerFactory(() => EditProfileViewModel());
  locator.registerFactory(() => SettingsViewModel());
  locator.registerFactory(() => ConfirmSwitchPopupViewModel());
  locator.registerFactory(() => MySwitchesViewModel());
  locator.registerFactory(() => SwitchStatusCardViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => YourMenuCardViewModel());
  locator.registerFactory(() => OtherMenuCardViewModel());
}
