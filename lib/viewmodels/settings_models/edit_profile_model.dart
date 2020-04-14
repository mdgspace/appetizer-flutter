import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class EditProfileModel extends BaseModel {
  UserApi _userApi = locator<UserApi>();

  Me _updatedUserDetails;

  Me get updatedUserDetails => _updatedUserDetails;

  set updatedUserDetails(Me updatedUserDetails) {
    _updatedUserDetails = updatedUserDetails;
    notifyListeners();
  }

  Future updateUserDetails(String email, String contactNo) async {
    setState(ViewState.Busy);
    try {
      updatedUserDetails = await _userApi.userMePatch(email, contactNo);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
