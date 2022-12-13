import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/menu_api.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class OtherMenuViewModel extends BaseModel {
  final MenuApi _menuApi = locator<MenuApi>();
  final UserApi _userApi = locator<UserApi>();

  late String _hostelCode;

  String get hostelCode => _hostelCode;

  set hostelCode(String hostelCode) {
    _hostelCode = hostelCode;
    notifyListeners();
  }

  late WeekMenu _hostelWeekMenu;

  WeekMenu get hostelWeekMenu => _hostelWeekMenu;

  set hostelWeekMenu(WeekMenu hostelWeekMenu) {
    _hostelWeekMenu = hostelWeekMenu;
    notifyListeners();
  }

  Future fetchInitialCheckedStatus() async {
    try {
      var userDetails = await _userApi.getCurrentUser();
      isCheckedOut = userDetails.isCheckedOut;
      notifyListeners();
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future<void> fetchHostelWeekMenu(int weekId, String hostelCode) async {
    setState(ViewState.Busy);
    try {
      hostelWeekMenu = await _menuApi.weekMenuMultiMessing(weekId, hostelCode);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }
}
