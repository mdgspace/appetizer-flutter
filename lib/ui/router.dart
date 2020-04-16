import 'package:appetizer/ui/FAQ/faq_screen.dart';
import 'package:appetizer/ui/help/help.dart';
import 'package:appetizer/ui/login/login.dart';
import 'package:appetizer/ui/menu/home.dart';
import 'package:appetizer/ui/my_leaves/my_leaves_screen.dart';
import 'package:appetizer/ui/my_rebates/my_rebates_screen.dart';
import 'package:appetizer/ui/my_switches/my_switches_screen.dart';
import 'package:appetizer/ui/notification_history/noti_history_screen.dart';
import 'package:appetizer/ui/on_boarding/onBoarding.dart';
import 'package:appetizer/ui/password/forgot_password.dart';
import 'package:appetizer/ui/settings/settings_screen.dart';
import 'package:appetizer/ui/user_feedback/user_feedback.dart';
import 'package:flutter/material.dart';

class Router {
  static const String initialRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        var token = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => Home(
            token: token,
          ),
        );
      case 'on_boarding':
        return MaterialPageRoute(builder: (_) => OnBoarding());
      case 'login':
        var code = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => Login(
            code: code,
          ),
        );
      case 'user_feedback':
        return MaterialPageRoute(builder: (_) => UserFeedback());
      case 'my_leaves':
        return MaterialPageRoute(builder: (_) => MyLeaves());
      case 'my_switches':
        return MaterialPageRoute(builder: (_) => MySwitches());
      case 'my_rebates':
        return MaterialPageRoute(builder: (_) => MyRebates());
      case 'notification_history':
        return MaterialPageRoute(builder: (_) => NotificationHistory());
      case 'settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case 'faq_list':
        return MaterialPageRoute(builder: (_) => FaqList());
      case 'settings':
        return MaterialPageRoute(builder: (_) => Settings());
      case 'help':
        return MaterialPageRoute(builder: (_) => Help());
      case 'forgot_password':
        return MaterialPageRoute(builder: (_) => ForgotPass());
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
