import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/multimessing/switchable_meal.dart';
import 'package:appetizer/services/api/multimessing_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/ui/multimessing/switch_confirmed_view.dart';
import 'package:appetizer/utils/string_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SwitchableMealsViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final MultimessingApi _multimessingApi = locator<MultimessingApi>();

  bool _isMealSwitched;

  bool get isMealSwitched => _isMealSwitched;

  set isMealSwitched(bool isMealSwitched) {
    _isMealSwitched = isMealSwitched;
    notifyListeners();
  }

  List<SwitchableMeal> _listOfSwitchableMeals;

  List<SwitchableMeal> get listOfSwitchableMeals => _listOfSwitchableMeals;

  set listOfSwitchableMeals(List<SwitchableMeal> listOfSwitchableMeals) {
    _listOfSwitchableMeals = listOfSwitchableMeals;
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

  Future getSwitchableMeals(int id) async {
    setState(ViewState.Busy);
    try {
      listOfSwitchableMeals = await _multimessingApi.getSwitchableMeals(id);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future<void> onSwitchTapped(int id, String toHostel) async {
    var _dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Confirm Switch',
      description: 'Are you sure you want to switch this meal?',
    );
    if (_dialogResponse.confirmed) {
      _dialogService.showCustomProgressDialog(title: 'Switching Meals');
      await switchMeals(id, StringUtils.hostelNameToCode(toHostel));
      _dialogService.popDialog();
      if (isMealSwitched) {
        await Get.offNamed(SwitchConfirmedView.id);
      } else {
        await Fluttertoast.showToast(msg: 'Unable to switch meal');
      }
    }
  }
}
