import 'package:appetizer/constants.dart';
import 'package:appetizer/database/app_database.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/api/menu_api.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourMenuViewModel extends BaseModel {
  final MenuApi _menuApi = locator<MenuApi>();

  WeekMenu _currentWeekYourMeals;

  WeekMenu get currentWeekYourMeals => _currentWeekYourMeals;

  set currentWeekYourMeals(WeekMenu currentWeekYourMeals) {
    _currentWeekYourMeals = currentWeekYourMeals;
    notifyListeners();
  }

  WeekMenu _selectedWeekYourMeals;

  WeekMenu get selectedWeekYourMeals => _selectedWeekYourMeals;

  set selectedWeekYourMeals(WeekMenu selectedWeekYourMeals) {
    _selectedWeekYourMeals = selectedWeekYourMeals;
    notifyListeners();
  }

  Future<void> currentWeekMenuYourMeals() async {
    setState(ViewState.Busy);
    try {
      currentWeekYourMeals = await _menuApi
          .weekMenuForYourMeals(DateTimeUtils.getWeekNumber(DateTime.now()));
      setState(ViewState.Idle);
    } on Failure catch (f) {
      if (f.message == Constants.NO_INTERNET_CONNECTION) {
        currentWeekYourMeals = await _menuApi.weekMenuFromDb();
        await updateMealDb(currentWeekYourMeals);
        setState(ViewState.Idle);
      } else {
        setState(ViewState.Error);
        setErrorMessage(f.message);
      }
    }
  }

  Future<void> selectedWeekMenuYourMeals(int weekId) async {
    setState(ViewState.Busy);
    try {
      selectedWeekYourMeals = await _menuApi.weekMenuForYourMeals(weekId);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      if (f.message == Constants.NO_INTERNET_CONNECTION &&
          weekId == DateTimeUtils.getWeekNumber(DateTime.now())) {
        selectedWeekYourMeals = await _menuApi.weekMenuFromDb();
        await updateMealDb(selectedWeekYourMeals);
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
