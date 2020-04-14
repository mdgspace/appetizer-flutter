import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class ResetPasswordModel extends BaseModel {
  UserApi _userApi = locator<UserApi>();

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
          userPasswordResetDetail.detail == "password changed successfully"
              ? true
              : false;
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
