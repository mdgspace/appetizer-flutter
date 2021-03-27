import 'package:appetizer/constants.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/user.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/services/push_notification_service.dart';
import 'package:appetizer/ui/login/login.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:get/get.dart';

class SettingsViewModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  final DialogService _dialogService = locator<DialogService>();

  User _userDetails;

  User get userDetails => _userDetails;

  set userDetails(User userDetails) {
    _userDetails = userDetails;
    notifyListeners();
  }

  Future getUserDetails() async {
    setState(ViewState.Busy);
    try {
      userDetails = await _userApi.getCurrentUser();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      if (f.message == Constants.NO_INTERNET_CONNECTION) {
        userDetails = currentUser;
        setState(ViewState.Idle);
      } else {
        setState(ViewState.Error);
        setErrorMessage(f.message);
      }
    }
  }

  Future logout() async {
    setState(ViewState.Busy);
    try {
      await _userApi.userLogout();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future onLogoutTap() async {
    var _dialog = await _dialogService.showConfirmationDialog(
      title: 'Log Out',
      description: 'Are you sure you want to log out?',
      confirmationTitle: 'LOGOUT',
    );

    if (_dialog.confirmed) {
      _dialogService.showCustomProgressDialog(title: 'Logging You Out');
      await logout();
      _dialogService.popDialog();
      await _pushNotificationService.fcm
          .unsubscribeFromTopic('release-' + currentUser.hostelCode);
      await Get.offAllNamed(Login.id);
      isLoggedIn = false;
      token = null;
    }
  }
}
