import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/services/navigation_service.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class ForgotPasswordModel extends BaseModel {
  UserApi _userApi = locator<UserApi>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();

  bool _isResetEmailSent;

  bool get isResetEmailSent => _isResetEmailSent;

  set isResetEmailSent(bool isResetEmailSent) {
    _isResetEmailSent = isResetEmailSent;
    notifyListeners();
  }

  Future sendResetEmail(String email) async {
    _dialogService.showCustomProgressDialog(title: "Sending Email");
    setState(ViewState.Busy);
    try {
      var resetEmailDetail = await _userApi.userReset(email);
      isResetEmailSent =
          resetEmailDetail.detail == "link has been emailed" ? true : false;
      setState(ViewState.Idle);
      showSnackBar(forgotPasswordViewScaffoldKey, "link has been emailed");
      Future.delayed(new Duration(seconds: 1), _navigationService.pop);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
      showSnackBar(forgotPasswordViewScaffoldKey, errorMessage);
    }
  }
}
