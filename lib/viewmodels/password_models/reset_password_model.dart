import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class ResetPasswordModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();
  final DialogService _dialogService = locator<DialogService>();

  bool _isUserPasswordReset;

  bool get isUserPasswordReset => _isUserPasswordReset;

  set isUserPasswordReset(bool isUserPasswordReset) {
    _isUserPasswordReset = isUserPasswordReset;
    notifyListeners();
  }

  Future resetPassword(String oldPassword, String newPassword) async {
    setState(ViewState.Busy);
    try {
      var userPasswordResetDetail =
          await _userApi.userPasswordReset(oldPassword, newPassword);
      isUserPasswordReset =
          userPasswordResetDetail.detail == 'password changed successfully'
              ? true
              : false;
      setState(ViewState.Idle);
      showSnackBar(
          resetPasswordViewScaffoldKey, 'Password changed successfully');
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
      showSnackBar(resetPasswordViewScaffoldKey, errorMessage);
    }
  }

  Future onResetPasswordTapped(String oldPassword, String newPassword) async {
    _dialogService.showCustomProgressDialog(title: 'Updating Password');
    await resetPassword(oldPassword, newPassword);
    _dialogService.dialogNavigationKey.currentState.pop();
  }
}
