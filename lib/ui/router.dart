import 'package:appetizer/models/user/oauth.dart';
import 'package:appetizer/ui/FAQ/faq_screen.dart';
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

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'on_boarding':
        return MaterialPageRoute(builder: (_) => OnBoarding());
      case 'login':
        var code = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => Login(
            code: code,
          ),
        );
      case 'home':
        var token = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => Home(
            token: token,
          ),
        );
      case 'user_feedback':
        return MaterialPageRoute(builder: (_) => UserFeedback());
      case 'my_leaves':
        return MaterialPageRoute(builder: (_) => MyLeaves());
      case 'my_leaves_history':
        return MaterialPageRoute(builder: (_) => MyLeavesHistory());
      case 'my_switches':
        return MaterialPageRoute(builder: (_) => MySwitches());
      case 'my_rebates':
        return MaterialPageRoute(builder: (_) => MyRebates());
      case 'rebates_history_screen':
        return MaterialPageRoute(builder: (_) => RebateHistoryScreen());
      case 'notification_history':
        return MaterialPageRoute(builder: (_) => NotificationHistory());
      case 'settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case 'faq_list':
        return MaterialPageRoute(builder: (_) => FaqList());
      case 'help':
        return MaterialPageRoute(builder: (_) => Help());
      case 'edit_profile':
        return MaterialPageRoute(builder: (_) => EditProfile());
      case 'forgot_pass':
        return MaterialPageRoute(builder: (_) => ForgotPass());
      case 'choose_new_pass':
        var studentData = settings.arguments as StudentData;
        return MaterialPageRoute(
          builder: (_) => ChooseNewPass(
            studentData: studentData,
          ),
        );
      case 'reset_password':
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case 'confirmed_switch_screen':
        return MaterialPageRoute(builder: (_) => ConfirmedSwitchScreen());
      case 'new_feedback':
        return MaterialPageRoute(builder: (_) => NewFeedback());
      case 'switchable_meals_screen':
        var id = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => SwitchableMealsScreen(id: id));
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
