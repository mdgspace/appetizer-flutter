import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class ForgotPasswordModel extends BaseModel {
  UserApi _userApi = locator<UserApi>();

  bool _isResetEmailSent;

  bool get isResetEmailSent => _isResetEmailSent;

  set isResetEmailSent(bool isResetEmailSent) {
    _isResetEmailSent = isResetEmailSent;
    notifyListeners();
  }

  Future sendResetEmail(String email) async {
    setState(ViewState.Busy);
    try {
      var resetEmailDetail = await _userApi.userReset(email);
      isResetEmailSent =
          resetEmailDetail.detail == "link has been emailed" ? true : false;
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
