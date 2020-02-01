import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/models/user/user_details_shared_pref.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:flutter/foundation.dart';

class YourMenuModel extends ChangeNotifier {
  Week _currentWeekYourMeals;
  Week _selectedWeekYourMeals;
  UserDetailsSharedPref _userDetails;
  //Convert to enum;
  bool _isFetching;

  YourMenuModel(UserDetailsSharedPref userDetails) {
    _userDetails = userDetails;
    currentWeekMenuYourMeals();
  }

  Week get currentWeekYourMeals => _currentWeekYourMeals;
  Week get selectedWeekYourMeals => _selectedWeekYourMeals;
  bool get isFetching => _isFetching;


  void currentWeekMenuYourMeals() async {
    _isFetching = true;
    notifyListeners();
    _currentWeekYourMeals = await menuWeekForYourMeals(
        _userDetails.token, DateTimeUtils.getWeekNumber(DateTime.now()));
    _selectedWeekYourMeals = _currentWeekYourMeals;
    _isFetching = false;
    notifyListeners();
  }

  void selectedWeekMenuYourMeals(int weekId) async {
    _isFetching = true;
    notifyListeners();
    print("SELECTED WEEK ${weekId}");
    menuWeekForYourMeals(_userDetails.token, weekId).then((week){
      _selectedWeekYourMeals = week;
      print("_selectWekk : ${_selectedWeekYourMeals}");
      _isFetching = false;
      notifyListeners();
    }).catchError((e){
      print(e);
    });
  }

}

class OtherMenuModel extends ChangeNotifier {

  int _weekId;
  String _hostelCode;
  UserDetailsSharedPref _userDetails;
  Week _hostelWeekMenu;
  bool _isFetching;

  set setHostelCode(String value) {
    _hostelCode = value;
    print("hostel code set to: $_hostelCode");
  }

  String get hostelCode => _hostelCode;
  Week get hostelWeekMenu => _hostelWeekMenu;
  bool get isFetching => _isFetching;

  OtherMenuModel(UserDetailsSharedPref userDetails, String hostelCode){
    _userDetails = userDetails;
    _weekId = DateTimeUtils.getWeekNumber(DateTime.now());
    _hostelCode = hostelCode;
    print("Hostel code set $_hostelCode");

//    getOtherMenu(DateTimeUtils.getWeekNumber(DateTime.now()));

  }

  void getOtherMenu(int weekId) async{
    _isFetching = true;
    notifyListeners();
    menuWeekMultiMessing(_userDetails.token, weekId, _hostelCode).then((weekMenu){
      print("FETCHED $_hostelCode: $weekMenu");
    _isFetching = false;
    _hostelWeekMenu = weekMenu;
    print("INSIDE FETCHER: ${_hostelWeekMenu.toJson()}");
    notifyListeners();
    }).catchError((e){
      print(e);
    });
  }

}