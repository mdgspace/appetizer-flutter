import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/api/menu.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class ConfirmSwitchPopupModel extends BaseModel {
  MultimessingApi _multimessingApi = locator<MultimessingApi>();
  MenuApi _menuApi = locator<MenuApi>();

  bool _isMealSwitched;

  bool get isMealSwitched => _isMealSwitched;

  set isMealSwitched(bool isMealSwitched) {
    _isMealSwitched = isMealSwitched;
    notifyListeners();
  }

  Week _menuWeekMultimessing;

  Week get menuWeekMultimessing => _menuWeekMultimessing;

  set menuWeekMultimessing(Week menuWeekMultimessing) {
    _menuWeekMultimessing = menuWeekMultimessing;
    notifyListeners();
  }

  Future switchMeals(int id, String toHostel) async {
    setState(ViewState.Busy);
    try {
      isMealSwitched = await _multimessingApi.switchMeals(id, toHostel);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }

  Future getMenuWeekMultimessing(int weekId, String hostelCode) async {
    setState(ViewState.Busy);
    try {
      menuWeekMultimessing =
          await _menuApi.menuWeekMultiMessing(weekId, hostelCode);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
