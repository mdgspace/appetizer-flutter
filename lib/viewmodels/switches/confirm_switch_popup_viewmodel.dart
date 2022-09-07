import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import '../../models/menu/week_menu.dart';
import 'package:appetizer/services/api/menu_api.dart';
import 'package:appetizer/services/api/multimessing_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/ui/multimessing/switch_confirmed_view.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/utils/string_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ConfirmSwitchPopupViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final MultimessingApi _multimessingApi = locator<MultimessingApi>();
  final MenuApi _menuApi = locator<MenuApi>();

  Meal _fromMeal;

  Meal get fromMeal => _fromMeal;

  set fromMeal(Meal fromMeal) {
    _fromMeal = fromMeal;
    notifyListeners();
  }

  Meal _toMeal;

  Meal get toMeal => _toMeal;

  set toMeal(Meal toMeal) {
    _toMeal = toMeal;
    notifyListeners();
  }

  bool _isMealSwitched;

  bool get isMealSwitched => _isMealSwitched;

  set isMealSwitched(bool isMealSwitched) {
    _isMealSwitched = isMealSwitched;
    notifyListeners();
  }

  WeekMenu _weekMenuMultimessing;

  WeekMenu get weekMenuMultimessing => _weekMenuMultimessing;

  set weekMenuMultimessing(WeekMenu weekMenuMultimessing) {
    _weekMenuMultimessing = weekMenuMultimessing;
    notifyListeners();
  }

  Future switchMeals(int id, String toHostel) async {
    setState(ViewState.Busy);
    try {
      isMealSwitched = await _multimessingApi.switchMeals(id, toHostel);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future getMenuWeekMultimessing() async {
    setState(ViewState.Busy);
    try {
      weekMenuMultimessing = await _menuApi.weekMenuMultiMessing(
        DateTimeUtils.getWeekNumber(toMeal.startDateTime),
        currentUser.hostelCode,
      );
      weekMenuMultimessing.dayMenus.forEach((dayMenu) {
        dayMenu.meals.forEach((meal) {
          if (dayMenu.date.day == toMeal.startDateTime.day &&
              toMeal.type == meal.type) {
            fromMeal = meal;
          }
        });
      });
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future<void> onConfirmSwitchPressed() async {
    _dialogService.showCustomProgressDialog(title: 'Switching Meals');
    await switchMeals(
      _fromMeal.id,
      StringUtils.hostelNameToCode(toMeal.hostelName),
    );
    _dialogService.popDialog();

    if (isMealSwitched) await Get.toNamed(SwitchConfirmedView.id);

    if (state == ViewState.Error) {
      Get.back();
      await Fluttertoast.showToast(msg: errorMessage);
    }
  }
}
