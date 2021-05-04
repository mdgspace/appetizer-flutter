import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/leave_api.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/services/remote_config_service.dart';
import 'package:appetizer/utils/snackbar_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class LeaveStatusCardViewModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();
  final LeaveApi _leaveApi = locator<LeaveApi>();
  final DialogService _dialogService = locator<DialogService>();
  final RemoteConfigService _remoteConfigService =
      locator<RemoteConfigService>();

  Future fetchInitialCheckStatus() async {
    setState(ViewState.Busy);
    try {
      var user = await _userApi.getCurrentUser();
      isCheckedOut = user.isCheckedOut;
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future toggleCheckState() async {
    setState(ViewState.Busy);
    try {
      if (isCheckedOut) {
        isCheckedOut = await _leaveApi.checkin();
      } else {
        isCheckedOut = await _leaveApi.checkout();
      }
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future onCheckTapped() async {
    if (_remoteConfigService.isCheckEnabled) {
      if (!isCheckedOut) {
        var dialogResponse = await _dialogService.showConfirmationDialog(
          title: 'Check Out',
          description: 'Are you sure you would like to check out?',
          confirmationTitle: 'CHECK OUT',
        );

        if (dialogResponse.confirmed) {
          await toggleCheckState();
          if (isCheckedOut) {
            SnackBarUtils.showDark('You have checked out');
          }
        }
      } else {
        await toggleCheckState();
        if (!isCheckedOut) {
          SnackBarUtils.showDark('You have checked in');
        }
      }
    } else {
      SnackBarUtils.showDark(
          'Checkout through Appetizer is temporarily disabled!');
    }
  }
}
