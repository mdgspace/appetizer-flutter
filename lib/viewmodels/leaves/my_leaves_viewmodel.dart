import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/leave_api.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class MyLeavesViewModel extends BaseModel {
  final LeaveApi _leaveApi = locator<LeaveApi>();

  int? _leaveCount;

  int? get leaveCount => _leaveCount;

  set leaveCount(int? leaveCount) {
    _leaveCount = leaveCount;
    notifyListeners();
  }

  Future getRemainingLeaves() async {
    setState(ViewState.Busy);
    try {
      leaveCount = await _leaveApi.remainingLeaves();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }
}
