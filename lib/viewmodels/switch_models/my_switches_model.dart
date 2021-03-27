import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/multimessing/remaining_switch_count.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class MySwitchesModel extends BaseModel {
  final MultimessingApi _multimessingApi = locator<MultimessingApi>();

  SwitchCount _switchCount;

  SwitchCount get switchCount => _switchCount;

  set switchCount(SwitchCount switchCount) {
    _switchCount = switchCount;
    notifyListeners();
  }

  Future getRemainingSwitches() async {
    setState(ViewState.Busy);
    try {
      switchCount = await _multimessingApi.remainingSwitches();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
