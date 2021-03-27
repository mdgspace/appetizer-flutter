import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/user/login.dart';
import 'package:appetizer/models/user/oauth.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/ui/menu/home.dart';
import 'package:appetizer/ui/password/choose_new_password.dart';
import 'package:appetizer/utils/user_details.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class LoginModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();
  final DialogService _dialogService = locator<DialogService>();

  Login _login;

  Login get login => _login;

  set login(Login login) {
    _login = login;
    notifyListeners();
  }

  bool _isLoginSuccessful = false;

  bool get isLoginSuccessful => _isLoginSuccessful;

  set isLoginSuccessful(bool isLoginSuccessful) {
    _isLoginSuccessful = isLoginSuccessful;
    notifyListeners();
  }

  bool _areCredentialsCorrect;

  bool get areCredentialsCorrect => _areCredentialsCorrect;

  set areCredentialsCorrect(bool areCredentialsCorrect) {
    _areCredentialsCorrect = areCredentialsCorrect;
    notifyListeners();
  }

  var _oauthResponse;

  get oauthResponse => _oauthResponse;

  set oauthResponse(var oauthResponse) {
    _oauthResponse = oauthResponse;
    notifyListeners();
  }

  Future loginWithEnrollmentAndPassword(
      {String enrollment, String password}) async {
    setState(ViewState.Busy);
    try {
      login = await _userApi.userLogin(enrollment, password);
      isLoginSuccessful = true;
      token = login.token;
      isLoggedIn = true;
      isCheckedOut = login.isCheckedOut;
      currentUser = login;
      var fcm = FirebaseMessaging();
      await fcm.subscribeToTopic('release-' + login.hostelCode);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      isLoginSuccessful = false;
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }

  Future getOAuthResponse(String code) async {
    try {
      oauthResponse = await _userApi.oAuthRedirect(code);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }

  Future verifyUser(String code) async {
    _dialogService.showCustomProgressDialog(title: 'Fetching Details');
    await getOAuthResponse(code);
    print('Code ' + code);
    if (oauthResponse != null) {
      StudentData studentData = oauthResponse.studentData;
      if (oauthResponse.isNew) {
        _dialogService.popDialog();
        _dialogService.showCustomProgressDialog(title: 'Redirecting');
        await Future.delayed(Duration(milliseconds: 500));
        _dialogService.popDialog();
        await Get.offNamed(ChooseNewPass.id, arguments: studentData);
      } else {
        if (oauthResponse.token != null) {
          _dialogService.popDialog();
          _dialogService.showCustomProgressDialog(title: 'Logging You In');
          currentUser = UserDetailsUtils.getLoginFromStudentData(
              studentData, oauthResponse.token);
          await Future.delayed(const Duration(milliseconds: 500));
          _dialogService.popDialog();
          await Get.offNamed(Home.id, arguments: oauthResponse.token);
        }
      }
    }
  }
}
