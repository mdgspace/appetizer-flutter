import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/ui/login/login.dart';
import 'package:appetizer/utils/get_week_id.dart';
import 'package:flutter/cupertino.dart';

class MenuModel extends ChangeNotifier {
  Week _currentWeek;

  MenuModel() {
    currentWeekMenu();
  }

  Week get data => _currentWeek;


  void currentWeekMenu() {
    // TODO: store user details in a separate model (user details should be fetched only once during the start of the app
    getUserDetails().then((details) async {
      _currentWeek = await menuWeek(
          details.getString("token"), getWeekNumber(DateTime.now()));
      notifyListeners();
    });
  }
}
