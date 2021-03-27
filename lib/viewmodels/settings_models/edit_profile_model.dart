import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/utils/user_details.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class EditProfileModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();
  final DialogService _dialogService = locator<DialogService>();

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
      currentUser = UserDetailsUtils.getLoginModelFromMe(updatedUserDetails);
      setState(ViewState.Idle);
      showSnackBar(editProfileViewScaffoldKey, 'User details updated');
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
      showSnackBar(editProfileViewScaffoldKey, errorMessage);
    }
  }

  Future saveUserDetails(String email, String contactNo) async {
    _dialogService.showCustomProgressDialog(title: 'Saving User Details');
    await updateUserDetails(email, contactNo);
    _dialogService.dialogNavigationKey.currentState.pop();
  }
}
