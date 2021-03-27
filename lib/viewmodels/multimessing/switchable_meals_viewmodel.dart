import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/multimessing/switchable_meal.dart';
import 'package:appetizer/services/api/multimessing_api.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class SwitchableMealsViewModel extends BaseModel {
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
}
