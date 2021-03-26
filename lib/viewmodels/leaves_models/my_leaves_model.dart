import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/leaves/remaining_leave_count.dart';
import 'package:appetizer/services/api/leave.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class MyLeavesModel extends BaseModel {
  LeaveApi _leaveApi = locator<LeaveApi>();

  LeaveCount _leaveCount;

  LeaveCount get leaveCount => _leaveCount;

  set leaveCount(LeaveCount leaveCount) {
    _leaveCount = leaveCount;
    notifyListeners();
  }

  Future getRemainingLeaves() async {
    setState(ViewState.Busy);
    try {
      leaveCount = await _leaveApi.remainingLeaves();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
