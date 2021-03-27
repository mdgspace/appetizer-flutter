import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/user.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/utils/snackbar_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class EditProfileViewModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();
  final DialogService _dialogService = locator<DialogService>();

  User _updatedUserDetails;

  User get updatedUserDetails => _updatedUserDetails;

  set updatedUserDetails(User updatedUserDetails) {
    _updatedUserDetails = updatedUserDetails;
    notifyListeners();
  }

  Future updateUserDetails(String email, String contactNo) async {
    setState(ViewState.Busy);
    try {
      updatedUserDetails = await _userApi.updateUser(email, contactNo);
      currentUser = updatedUserDetails;
      setState(ViewState.Idle);
      SnackBarUtils.showDark('User details updated');
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
      SnackBarUtils.showDark(errorMessage);
    }
  }

  Future saveUserDetails(String email, String contactNo) async {
    _dialogService.showCustomProgressDialog(title: 'Saving User Details');
    await updateUserDetails(email, contactNo);
    _dialogService.popDialog();
  }
}
