import 'package:appetizer/data/constants/env_config.dart';

class ApiEndpoints {
  static const String baseUrl = EnvironmentConfig.BASE_URL;

  static const String checkVersion =
      '/panel/version/expire/{platform}/{versionNumber}';

  static const String coupon = '/api/coupon/';
  static const String couponWithId = '/api/coupon/{couponId}';
  static const String allCoupons = '/api/coupon/all';

  static const String submittedFeedback = '/api/feedback/all/';
  static const String responseOfFeedback = '/api/feedback/response/list/';
  static const String newFeedback = '/api/feedback/';

  static const String remainingLeaves = '/api/leave/count/remaining/';
  static const String getLeaves = '/api/leave/all/';
  static const String check = '/api/leave/check/';
  static const String leave = '/api/leave/';
  static const String cancelLeave = '/api/leave/meal/{id}';

  static const String weekMenuMultimessing = '/api/menu/week/v2/';
  static const String weekMenuForYourMeals = '/api/menu/my_week/';
  static const String weekMenu = '/api/menu/week/';
  static const String dayMenu = '/api/menu/{week}/{dayOfWeek}';

  // TODO: add multimessing endpoints

  static const String monthlyRebate = '/api/transaction/rebate/current/';
  static const String yearlyRebate = '/api/transaction/list/expenses/';
  static const String faqs = '/api/faqs/';

  static const String status = '/api/user/status/';
  static const String login = '/api/user/login/';
  static const String logout = '/api/user/logout/';
  static const String user = '/api/user/me/';
  static const String password = '/api/user/me/password/';
  static const String resetpassword = '/api/user/me/password/reset/';
  static const String oAuthRedirect = '/api/user/oauth/omniport/redirect/';
  static const String oAuthComplete = '/api/user/oauth/complete/';
  static const String notifications = '/api/user/message/list/';
}
