import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/multimessing_api.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class MySwitchesViewModel extends BaseModel {
  final MultimessingApi _multimessingApi = locator<MultimessingApi>();

  int? _switchCount;

  int? get switchCount => _switchCount;

  set switchCount(int? switchCount) {
    _switchCount = switchCount;
    notifyListeners();
  }

  Future getRemainingSwitches() async {
    setState(ViewState.Busy);
    try {
      switchCount = await _multimessingApi.remainingSwitches();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }
}
