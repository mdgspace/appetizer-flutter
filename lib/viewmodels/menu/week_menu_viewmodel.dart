import 'package:appetizer/constants.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/menu_api.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class WeekMenuViewModel extends BaseModel {
  final MenuApi _menuApi = locator<MenuApi>();

  WeekMenu _currentWeekMenu;

  WeekMenu get currentWeekMenu => _currentWeekMenu;

  set currentWeekMenu(WeekMenu currentWeekMenu) {
    _currentWeekMenu = currentWeekMenu;
    notifyListeners();
  }

  Future<void> fetchCurrentWeekMenu() async {
    setState(ViewState.Busy);
    try {
      _currentWeekMenu = await _menuApi.currentWeekMenu();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      if (f.message == Constants.NO_INTERNET_CONNECTION) {
        currentWeekMenu = await _menuApi.weekMenuFromDb();
        setState(ViewState.Idle);
      } else {
        setState(ViewState.Error);
        setErrorMessage(f.message);
      }
    }
  }
}
