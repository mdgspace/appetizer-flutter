import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/api/menu.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class OtherMenuModel extends BaseModel {
  final MenuApi _menuApi = locator<MenuApi>();

  String _hostelCode;
  Week _hostelWeekMenu;

  String get hostelCode => _hostelCode;

  set hostelCode(String hostelCode) {
    _hostelCode = hostelCode;
    notifyListeners();
  }

  Week get hostelWeekMenu => _hostelWeekMenu;

  set hostelWeekMenu(Week hostelWeekMenu) {
    _hostelWeekMenu = hostelWeekMenu;
    notifyListeners();
  }

  Future<void> getOtherMenu(int weekId, String hostelCode) async {
    setState(ViewState.Busy);
    try {
      hostelWeekMenu = await _menuApi.menuWeekMultiMessing(weekId, hostelCode);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
