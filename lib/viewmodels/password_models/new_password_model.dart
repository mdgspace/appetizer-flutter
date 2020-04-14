import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/oauth.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class NewPasswordModel extends BaseModel {
  UserApi _userApi = locator<UserApi>();

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
}
