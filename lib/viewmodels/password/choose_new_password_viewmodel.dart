import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/oauth_user.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/ui/home_view.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:get/get.dart';

class NewPasswordViewModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();
  final DialogService _dialogService = locator<DialogService>();

  OAuthUser _oauthUser;

  OAuthUser get oauthUser => _oauthUser;

  set oauthUser(OAuthUser oauthUser) {
    _oauthUser = oauthUser;
    notifyListeners();
  }

  Future oAuthComplete(
      int enr, String password, String email, int contactNo) async {
    setState(ViewState.Busy);
    try {
      oauthUser = await _userApi.oAuthComplete(enr, password, email, contactNo);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future loginUser(
      int enr, String password, String email, int contactNo) async {
    _dialogService.showCustomProgressDialog(title: 'Logging You In');
    await oAuthComplete(enr, password, email, contactNo);
    _dialogService.popDialog();
    if (oauthUser.token != null) {
      var studentData = oauthUser.studentData;
      currentUser = studentData;
      await Get.offNamed(HomeView.id, arguments: oauthUser.token);
    } else {
      setState(ViewState.Error);
      setErrorMessage('Invalid Request');
    }
  }
}
