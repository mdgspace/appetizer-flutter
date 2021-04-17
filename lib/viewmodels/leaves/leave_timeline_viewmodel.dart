import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/leaves/paginated_leaves.dart';
import 'package:appetizer/services/api/leave_api.dart';
import 'package:appetizer/utils/snackbar_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class LeaveTimelineViewModel extends BaseModel {
  final LeaveApi _leaveApi = locator<LeaveApi>();

  PaginatedLeaves _paginatedLeaves;

  PaginatedLeaves get paginatedLeaves => _paginatedLeaves;

  set paginatedLeaves(PaginatedLeaves paginatedLeaves) {
    _paginatedLeaves = paginatedLeaves;
    notifyListeners();
  }

  Future fetchLeaves(int year, int month) async {
    setState(ViewState.Busy);
    try {
      paginatedLeaves = await _leaveApi.getLeaves(year, month);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
      SnackBarUtils.showDark(f.message);
    }
  }
}
