import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/utils/snackbar_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:get/get.dart';

class ForgotPasswordViewModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();
  final DialogService _dialogService = locator<DialogService>();

  bool _isResetEmailSent;

  bool get isResetEmailSent => _isResetEmailSent;

  set isResetEmailSent(bool isResetEmailSent) {
    _isResetEmailSent = isResetEmailSent;
    notifyListeners();
  }

  Future sendResetEmail(String email) async {
    _dialogService.showCustomProgressDialog(title: 'Sending Email');
    setState(ViewState.Busy);
    try {
      await _userApi.sendResetPasswordLink(email);
      isResetEmailSent = true;
      setState(ViewState.Idle);
      SnackBarUtils.showDark('link has been emailed');
      await Future.delayed(Duration(seconds: 1));
      Get.back();
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
      SnackBarUtils.showDark(errorMessage);
    }
  }
}
