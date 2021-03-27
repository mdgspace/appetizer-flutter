import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/oauth.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/ui/menu/home_view.dart';
import 'package:appetizer/utils/user_details.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:get/get.dart';

class NewPasswordModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();
  final DialogService _dialogService = locator<DialogService>();

  OauthResponse _oauthResponse;

  OauthResponse get oauthResponse => _oauthResponse;

  set oauthResponse(OauthResponse oauthResponse) {
    _oauthResponse = oauthResponse;
    notifyListeners();
  }

  Future oAuthComplete(
      int enr, String password, String email, int contactNo) async {
    setState(ViewState.Busy);
    try {
      oauthResponse =
          await _userApi.oAuthComplete(enr, password, email, contactNo);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }

  Future loginUser(
      int enr, String password, String email, int contactNo) async {
    _dialogService.showCustomProgressDialog(title: 'Logging You In');
    await oAuthComplete(enr, password, email, contactNo);
    _dialogService.popDialog();
    if (oauthResponse.token != null) {
      var studentData = oauthResponse.studentData;
      currentUser = UserDetailsUtils.getLoginFromStudentData(
          studentData, oauthResponse.token);
      await Get.offNamed(HomeView.id, arguments: oauthResponse.token);
    } else {
      //TODO
      print('Error');
    }
  }
}
