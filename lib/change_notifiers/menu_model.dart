import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/models/user/user_details_shared_pref.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:appetizer/utils/get_week_id.dart';
import 'package:appetizer/utils/user_details.dart';
import 'package:flutter/foundation.dart';

class YourMenuModel extends ChangeNotifier {
  Week _currentWeekYourMeals;
  Week _selectedWeekYourMeals;
  UserDetailsSharedPref _userDetails;
  //Convert to enum;
  int _isFetching;

  YourMenuModel(UserDetailsSharedPref userDetails) {
    _userDetails = userDetails;
    currentWeekMenuYourMeals();
  }

  Week get currentWeekYourMeals => _currentWeekYourMeals;
  Week get selectedWeekYourMeals => _selectedWeekYourMeals;
  int get isFetching => _isFetching;


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

}

class OtherMenuModel extends ChangeNotifier {

  int _weekId;
  String _hostelCode;

  UserDetailsSharedPref _userDetails;
  Week _hostelWeekMenu;
  bool _isFetching;

  String get hostelCode => _hostelCode;
  Week get hostelWeekMenu => _hostelWeekMenu;
  bool get isFetching => _isFetching;

  OtherMenuModel(UserDetailsSharedPref userDetails, String hostelCode){
    _userDetails = userDetails;
    _weekId = getWeekNumber(DateTime.now());
    _hostelCode = hostelCode;
  }

  void getOtherMenu(DateTime selectedDateTime, String selectedHostel) async{
    _isFetching = true;
    menuWeekMultiMessing(_userDetails.token, getWeekNumber(selectedDateTime), hostelCodeMap[selectedHostel]).then((weekMenu){
    _isFetching = false;
    _hostelWeekMenu = weekMenu;
    notifyListeners();
    }).catchError((e){
      print(e);
    });
  }

}