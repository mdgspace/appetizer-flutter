import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/multimessing/meal_switch_from_your_meals.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class SwitchableMealsModel extends BaseModel {
  MultimessingApi _multimessingApi = locator<MultimessingApi>();

  bool _isMealSwitched;

  bool get isMealSwitched => _isMealSwitched;

  set isMealSwitched(bool isMealSwitched) {
    _isMealSwitched = isMealSwitched;
    notifyListeners();
  }

  List<SwitchableMealsForYourMeal> _listOfSwitchableMeals;

  List<SwitchableMealsForYourMeal> get listOfSwitchableMeals =>
      _listOfSwitchableMeals;

  set listOfSwitchableMeals(
      List<SwitchableMealsForYourMeal> listOfSwitchableMeals) {
    _listOfSwitchableMeals = listOfSwitchableMeals;
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

  Future getSwitchableMeals(int id) async {
    setState(ViewState.Busy);
    try {
      listOfSwitchableMeals = await _multimessingApi.listSwitchableMeals(id);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
