import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/models/user/user_details_shared_pref.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/app_database.dart';

class YourMenuModel extends ChangeNotifier {
  Week _currentWeekYourMeals;
  Week _selectedWeekYourMeals;
  UserDetailsSharedPref _userDetails;
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
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _currentWeekYourMeals = await menuWeekFromDb();
    } else {
      _currentWeekYourMeals = await menuWeekForYourMeals(
          _userDetails.token, DateTimeUtils.getWeekNumber(DateTime.now()));
      updateMealDb(_currentWeekYourMeals);
    }
    _selectedWeekYourMeals = _currentWeekYourMeals;
    _isFetching = false;
    notifyListeners();
  }

  void selectedWeekMenuYourMeals(int weekId) async {
    _isFetching = true;
    notifyListeners();
    menuWeekForYourMeals(_userDetails.token, weekId).then((week) async {
      _selectedWeekYourMeals = week;
      if (weekId == DateTimeUtils.getWeekNumber(DateTime.now())) {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          _selectedWeekYourMeals = await menuWeekFromDb();
        } else {
          _selectedWeekYourMeals = week;
        }
      }
      _isFetching = false;
      notifyListeners();
    }).catchError((e) {
      print(e);
    });
  }

  static const String MEAL_STORE_NAME = 'meals';

  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Week objects converted to Map
  final _mealStore = intMapStoreFactory.store(MEAL_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<void> updateMealDb(Week weekMenu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int mealKey = await _mealStore.add(await _db, weekMenu.toJson());
    prefs.setInt("mealKey", mealKey);
  }
}

class OtherMenuModel extends ChangeNotifier {
  String _hostelCode;
  UserDetailsSharedPref _userDetails;
  Week _hostelWeekMenu;
  bool _isFetching;

  set setHostelCode(String value) {
    _hostelCode = value;
  }

  String get hostelCode => _hostelCode;

  Week get hostelWeekMenu => _hostelWeekMenu;

  bool get isFetching => _isFetching;

  OtherMenuModel(UserDetailsSharedPref userDetails, String hostelCode) {
    _userDetails = userDetails;
    _hostelCode = hostelCode;
  }

  void getOtherMenu(int weekId) async {
    _isFetching = true;
    notifyListeners();
    menuWeekMultiMessing(_userDetails.token, weekId, _hostelCode)
        .then((weekMenu) {
      _isFetching = false;
      _hostelWeekMenu = weekMenu;
      notifyListeners();
    }).catchError((e) {
      print(e);
    });
  }
}
