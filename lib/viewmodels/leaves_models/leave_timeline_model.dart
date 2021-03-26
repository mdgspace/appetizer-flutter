import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/leaves/leave_list.dart';
import 'package:appetizer/services/api/leave.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class LeaveTimelineModel extends BaseModel {
  final LeaveApi _leaveApi = locator<LeaveApi>();

  LeaveList _leaveList;

  LeaveList get leaveList => _leaveList;

  set leaveList(LeaveList leaveList) {
    _leaveList = leaveList;
    notifyListeners();
  }

  Future getLeaveList(int year, int month) async {
    setState(ViewState.Busy);
    try {
      leaveList = await _leaveApi.leaveList(year, month);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
