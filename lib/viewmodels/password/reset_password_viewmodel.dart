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

  Future resetPassword(String oldPassword, String newPassword) async {
    setState(ViewState.Busy);
    try {
      await _userApi.resetUserPassword(oldPassword, newPassword);
      _isUserPasswordReset = true;
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future onResetPasswordTapped(String oldPassword, String newPassword) async {
    _dialogService.showCustomProgressDialog(title: 'Updating Password');
    await resetPassword(oldPassword, newPassword);
    _dialogService.popDialog();

    if (_isUserPasswordReset ?? false) {
      Get.back();
      SnackBarUtils.showDark('Info', 'Password changed successfully');
    } else {
      SnackBarUtils.showDark('Error', 'Unable to change password!');
    }
  }
}
