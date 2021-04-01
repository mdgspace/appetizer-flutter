import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/utils/snackbar_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:get/get.dart';

class ResetPasswordViewModel extends BaseModel {
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
          await _userApi.resetUserPassword(oldPassword, newPassword);
      isUserPasswordReset =
          userPasswordResetDetail.detail == 'password changed successfully'
              ? true
              : false;
      setState(ViewState.Idle);
      SnackBarUtils.showDark('Password changed successfully');
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
      SnackBarUtils.showDark(errorMessage);
    }
  }

  Future onResetPasswordTapped(String oldPassword, String newPassword) async {
    _dialogService.showCustomProgressDialog(title: 'Updating Password');
    await resetPassword(oldPassword, newPassword);
    _dialogService.popDialog();

    if (state == ViewState.Idle) {
      Get.back();
    }
  }
}
