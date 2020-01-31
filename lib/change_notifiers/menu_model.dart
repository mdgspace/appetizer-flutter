import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/models/user/user_details_shared_pref.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:appetizer/utils/get_week_id.dart';
import 'package:appetizer/utils/user_details.dart';
import 'package:flutter/foundation.dart';

class MenuModel extends ChangeNotifier {
  Week _currentWeekYourMeals;

  Week _selectedWeekYourMeals;
  Week _selectedWeekMultiMessing;
  UserDetailsSharedPref _userDetails;
  //Convert to enum;
  int _isFetching;

  MenuModel(UserDetailsSharedPref userDetails) {
    _userDetails = userDetails;
    _isFetching = 1;
    currentWeekMenuYourMeals();
  }

  Week get currentWeekYourMeals => _currentWeekYourMeals;

  Week get menuYourMeals => _selectedWeekYourMeals;
  Week get menuMultiMessing => _selectedWeekMultiMessing;

  int get isFetching => _isFetching;

  // FIXME: Probably Changes made in backend side type mismatch error
/*
  void currentWeekMenu() {
    UserDetailsUtils.getUserDetails().then((details) async {
      _currentWeekYourMeals = await menuWeek(
          details.getString("token"), getWeekNumber(DateTime.now()));
      notifyListeners();
    });
  }
*/

  void currentWeekMenuYourMeals() async {
    _isFetching = 1;
    notifyListeners();
    _currentWeekYourMeals = await menuWeekForYourMeals(
        _userDetails.token, getWeekNumber(DateTime.now()));
    _selectedWeekYourMeals = _currentWeekYourMeals;
    _isFetching = 0;
    notifyListeners();
  }

  void selectedWeekMenuYourMeals(DateTime dateTime) async {
    _isFetching = 1;
    notifyListeners();
    _selectedWeekYourMeals =
        await menuWeekForYourMeals(_userDetails.token, getWeekNumber(dateTime));
    _isFetching = 0;
    notifyListeners();
  }

  void selectedWeekMenuMultiMessing(
      String hostelCode, DateTime dateTime) async {
    _isFetching = 1;
    notifyListeners();
    _selectedWeekMultiMessing = await menuWeekMultiMessing(
        _userDetails.token, getWeekNumber(dateTime), hostelCode);
    _isFetching = 0;
    notifyListeners();
  }
}
