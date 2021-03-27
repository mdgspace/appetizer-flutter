import 'package:appetizer/models/user/oauth.dart';
import 'package:appetizer/ui/FAQ/faq_view.dart';
import 'package:appetizer/ui/help/help.dart';
import 'package:appetizer/ui/leave_history/leave_history_screen.dart';
import 'package:appetizer/ui/login/login.dart';
import 'package:appetizer/ui/menu/home.dart';
import 'package:appetizer/ui/multimessing/confirmed_switch_screen.dart';
import 'package:appetizer/ui/multimessing/switchable_meals_screen.dart';
import 'package:appetizer/ui/my_leaves/my_leaves_screen.dart';
import 'package:appetizer/ui/my_rebates/my_rebates_screen.dart';
import 'package:appetizer/ui/my_switches/my_switches_screen.dart';
import 'package:appetizer/ui/notification_history/noti_history_screen.dart';
import 'package:appetizer/ui/on_boarding/onBoarding.dart';
import 'package:appetizer/ui/password/choose_new_password.dart';
import 'package:appetizer/ui/password/forgot_password.dart';
import 'package:appetizer/ui/password/reset_password.dart';
import 'package:appetizer/ui/rebate_history/rebate_history_screen.dart';
import 'package:appetizer/ui/settings/edit_profile.dart';
import 'package:appetizer/ui/settings/settings_screen.dart';
import 'package:appetizer/ui/user_feedback/new_feedback.dart';
import 'package:appetizer/ui/user_feedback/user_feedback.dart';
import 'package:flutter/material.dart';

class AppetizerRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnBoarding.id:
        return MaterialPageRoute(builder: (_) => OnBoarding());
      case Login.id:
        var code = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => Login(
            code: code,
          ),
        );
      case Home.id:
        var token = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => Home(
            token: token,
          ),
        );
      case UserFeedback.id:
        return MaterialPageRoute(builder: (_) => UserFeedback());
      case MyLeaves.id:
        return MaterialPageRoute(builder: (_) => MyLeaves());
      case MyLeavesHistory.id:
        return MaterialPageRoute(builder: (_) => MyLeavesHistory());
      case MySwitches.id:
        return MaterialPageRoute(builder: (_) => MySwitches());
      case MyRebates.id:
        return MaterialPageRoute(builder: (_) => MyRebates());
      case RebateHistoryScreen.id:
        return MaterialPageRoute(builder: (_) => RebateHistoryScreen());
      case NotificationHistory.id:
        return MaterialPageRoute(builder: (_) => NotificationHistory());
      case Settings.id:
        return MaterialPageRoute(builder: (_) => Settings());
      case FaqView.id:
        return MaterialPageRoute(builder: (_) => FaqView());
      case Help.id:
        return MaterialPageRoute(builder: (_) => Help());
      case EditProfile.id:
        return MaterialPageRoute(builder: (_) => EditProfile());
      case ForgotPass.id:
        return MaterialPageRoute(builder: (_) => ForgotPass());
      case ChooseNewPass.id:
        var studentData = settings.arguments as StudentData;
        return MaterialPageRoute(
          builder: (_) => ChooseNewPass(
            studentData: studentData,
          ),
        );
      case ResetPassword.id:
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case ConfirmedSwitchScreen.id:
        return MaterialPageRoute(builder: (_) => ConfirmedSwitchScreen());
      case NewFeedback.id:
        return MaterialPageRoute(builder: (_) => NewFeedback());
      case SwitchableMealsScreen.id:
        var _mealId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => SwitchableMealsScreen(mealId: _mealId));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
