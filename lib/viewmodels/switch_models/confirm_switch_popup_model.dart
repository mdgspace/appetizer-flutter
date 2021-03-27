import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/api/menu_api.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class ConfirmSwitchPopupModel extends BaseModel {
  final MultimessingApi _multimessingApi = locator<MultimessingApi>();
  final MenuApi _menuApi = locator<MenuApi>();

  bool _isMealSwitched;

  bool get isMealSwitched => _isMealSwitched;

  set isMealSwitched(bool isMealSwitched) {
    _isMealSwitched = isMealSwitched;
    notifyListeners();
  }

  WeekMenu _menuWeekMultimessing;

  WeekMenu get menuWeekMultimessing => _menuWeekMultimessing;

  set menuWeekMultimessing(WeekMenu menuWeekMultimessing) {
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
          await _menuApi.weekMenuMultiMessing(weekId, hostelCode);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
