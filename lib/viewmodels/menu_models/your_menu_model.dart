import 'package:appetizer/constants.dart';
import 'package:appetizer/database/app_database.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/api/menu.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourMenuModel extends BaseModel {
  final MenuApi _menuApi = locator<MenuApi>();

  Week _currentWeekYourMeals;
  Week _selectedWeekYourMeals;

  Week get currentWeekYourMeals => _currentWeekYourMeals;

  set currentWeekYourMeals(Week currentWeekYourMeals) {
    _currentWeekYourMeals = currentWeekYourMeals;
    notifyListeners();
  }

  Week get selectedWeekYourMeals => _selectedWeekYourMeals;

  set selectedWeekYourMeals(Week selectedWeekYourMeals) {
    _selectedWeekYourMeals = selectedWeekYourMeals;
    notifyListeners();
  }

  Future<void> currentWeekMenuYourMeals() async {
    setState(ViewState.Busy);
    try {
      currentWeekYourMeals = await _menuApi
          .menuWeekForYourMeals(DateTimeUtils.getWeekNumber(DateTime.now()));
      setState(ViewState.Idle);
    } on Failure catch (f) {
      if (f.message == Constants.NO_INTERNET_CONNECTION) {
        currentWeekYourMeals = await _menuApi.menuWeekFromDb();
        await updateMealDb(currentWeekYourMeals);
        setState(ViewState.Idle);
      } else {
        print(f.message);
        setErrorMessage(f.message);
        setState(ViewState.Error);
      }
    }
  }

  Future<void> selectedWeekMenuYourMeals(int weekId) async {
    setState(ViewState.Busy);
    try {
      selectedWeekYourMeals = await _menuApi.menuWeekForYourMeals(weekId);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      if (f.message == Constants.NO_INTERNET_CONNECTION &&
          weekId == DateTimeUtils.getWeekNumber(DateTime.now())) {
        selectedWeekYourMeals = await _menuApi.menuWeekFromDb();
        await updateMealDb(selectedWeekYourMeals);
        setState(ViewState.Idle);
      } else {
        print(f.message);
        setErrorMessage(f.message);
        setState(ViewState.Error);
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

  Future<void> updateMealDb(Week weekMenu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int mealKey = await _mealStore.add(await _db, weekMenu.toJson());
    prefs.setInt("mealKey", mealKey);
  }
}
