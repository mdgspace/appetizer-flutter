import 'package:appetizer/constants.dart';
import 'package:appetizer/database/app_database.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/menu_api.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourMenuViewModel extends BaseModel {
  final MenuApi _menuApi = locator<MenuApi>();
  final UserApi _userApi = locator<UserApi>();

  WeekMenu _selectedWeekMenuYourMeals;

  WeekMenu get selectedWeekMenuYourMeals => _selectedWeekMenuYourMeals;

  set selectedWeekMenuYourMeals(WeekMenu selectedWeekMenuYourMeals) {
    _selectedWeekMenuYourMeals = selectedWeekMenuYourMeals;
    notifyListeners();
  }

  WeekMenu _selectedWeekMenu;

  WeekMenu get selectedWeekMenu => _selectedWeekMenu;

  set selectedWeekMenu(WeekMenu selectedWeekMenu) {
    _selectedWeekMenu = selectedWeekMenu;
    notifyListeners();
  }

  Future fetchInitialCheckedStatus() async {
    try {
      var userDetails = await _userApi.getCurrentUser();
      Globals.isCheckedOut = userDetails.isCheckedOut;
      notifyListeners();
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future<void> fetchSelectedWeekMenuYourMeals(int weekId) async {
    setState(ViewState.Busy);
    try {
      _selectedWeekMenuYourMeals = await _menuApi.weekMenuForYourMeals(weekId);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      if (f.message == Constants.NO_INTERNET_CONNECTION &&
          weekId == DateTimeUtils.getWeekNumber(DateTime.now())) {
        selectedWeekMenuYourMeals = await _menuApi.weekMenuFromDb();
        await updateMealDb(_selectedWeekMenuYourMeals);
        setState(ViewState.Idle);
      } else {
        setState(ViewState.Error);
        setErrorMessage(f.message);
      }
    }
  }

  Future<void> fetchSelectedWeekMenu(int weekId) async {
    setState(ViewState.Busy);
    try {
      _selectedWeekMenu = await _menuApi.weekMenuByWeekId(weekId);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      if (f.message == Constants.NO_INTERNET_CONNECTION &&
          weekId == DateTimeUtils.getWeekNumber(DateTime.now())) {
        selectedWeekMenu = await _menuApi.weekMenuFromDb();
        await updateMealDb(_selectedWeekMenu);
        setState(ViewState.Idle);
      } else {
        setState(ViewState.Error);
        setErrorMessage(f.message);
      }
    }
  }

  static const String MEAL_STORE_NAME = 'meals';

  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Week objects converted to Map
  final _mealStore = intMapStoreFactory.store(MEAL_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<void> updateMealDb(WeekMenu weekMenu) async {
    var prefs = await SharedPreferences.getInstance();
    var mealKey = await _mealStore.add(await _db, weekMenu.toJson());
    await prefs.setInt('mealKey', mealKey);
  }
}
