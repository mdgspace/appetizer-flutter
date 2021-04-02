import 'package:appetizer/models/user/user.dart';
import 'package:appetizer/ui/FAQ/faq_view.dart';
import 'package:appetizer/ui/help/help_view.dart';
import 'package:appetizer/ui/leave_history/leave_history_screen.dart';
import 'package:appetizer/ui/login/login_view.dart';
import 'package:appetizer/ui/home_view.dart';
import 'package:appetizer/ui/multimessing/switch_confirmed_view.dart';
import 'package:appetizer/ui/multimessing/switchable_meals_view.dart';
import 'package:appetizer/ui/my_leaves/my_leaves_view.dart';
import 'package:appetizer/ui/my_switches/my_switches_view.dart';
import 'package:appetizer/ui/notification_history/notification_history_view.dart';
import 'package:appetizer/ui/on_boarding/on_boarding_view.dart';
import 'package:appetizer/ui/password/choose_new_password.dart';
import 'package:appetizer/ui/password/forgot_password_view.dart';
import 'package:appetizer/ui/password/reset_password_view.dart';
import 'package:appetizer/ui/rebates/my_rebates_view.dart';
import 'package:appetizer/ui/rebates/rebates_history_view.dart';
import 'package:appetizer/ui/settings/edit_profile_view.dart';
import 'package:appetizer/ui/settings/settings_view.dart';
import 'package:appetizer/ui/user_feedback/new_feedback_view.dart';
import 'package:appetizer/ui/user_feedback/user_feedback_view.dart';
import 'package:flutter/material.dart';

class AppetizerRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case OnBoardingView.id:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      case LoginView.id:
        var code = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => LoginView(
            code: code,
          ),
        );
      case HomeView.id:
        var token = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => HomeView(
            token: token,
          ),
        );
      case UserFeedbackView.id:
        return MaterialPageRoute(builder: (_) => UserFeedbackView());
      case MyLeavesView.id:
        return MaterialPageRoute(builder: (_) => MyLeavesView());
      case MyLeavesHistory.id:
        return MaterialPageRoute(builder: (_) => MyLeavesHistory());
      case MySwitches.id:
        return MaterialPageRoute(builder: (_) => MySwitches());
      case MyRebatesView.id:
        return MaterialPageRoute(builder: (_) => MyRebatesView());
      case RebatesHistoryView.id:
        return MaterialPageRoute(builder: (_) => RebatesHistoryView());
      case NotificationHistoryView.id:
        return MaterialPageRoute(builder: (_) => NotificationHistoryView());
      case Settings.id:
        return MaterialPageRoute(builder: (_) => Settings());
      case FaqView.id:
        return MaterialPageRoute(builder: (_) => FaqView());
      case HelpView.id:
        return MaterialPageRoute(builder: (_) => HelpView());
      case EditProfileView.id:
        return MaterialPageRoute(builder: (_) => EditProfileView());
      case ForgotPasswordView.id:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case ChooseNewPasswordView.id:
        var user = settings.arguments as User;
        return MaterialPageRoute(
          builder: (_) => ChooseNewPasswordView(
            user: user,
          ),
        );
      case ResetPasswordView.id:
        return MaterialPageRoute(builder: (_) => ResetPasswordView());
      case SwitchConfirmedView.id:
        return MaterialPageRoute(builder: (_) => SwitchConfirmedView());
      case NewFeedbackView.id:
        return MaterialPageRoute(builder: (_) => NewFeedbackView());
      case SwitchableMealsView.id:
        var _mealId = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => SwitchableMealsView(mealId: _mealId));
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
