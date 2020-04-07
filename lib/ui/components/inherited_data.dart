import 'package:appetizer/models/user/user_details_shared_pref.dart';
import 'package:flutter/widgets.dart';

class InheritedData extends InheritedWidget {
  final UserDetailsSharedPref userDetails;

  InheritedData({Widget child, this.userDetails}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  UserDetailsSharedPref get getUserDetails => userDetails;

  static InheritedData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedData>();
}
