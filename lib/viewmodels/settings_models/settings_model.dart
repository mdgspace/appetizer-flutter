import 'package:appetizer/constants.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/detail.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/services/navigation_service.dart';
import 'package:appetizer/services/push_notification_service.dart';
import 'package:appetizer/utils/user_details.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class SettingsModel extends BaseModel {
  UserApi _userApi = locator<UserApi>();
  PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  Me _userDetails;

  Me get userDetails => _userDetails;

  set userDetails(Me userDetails) {
    _userDetails = userDetails;
    notifyListeners();
  }

  Detail _userLogoutDetail;

  Detail get userLogoutDetail => _userLogoutDetail;

  set userLogoutDetail(Detail userLogoutDetail) {
    _userLogoutDetail = userLogoutDetail;
    notifyListeners();
  }

  Future getUserDetails() async {
    setState(ViewState.Busy);
    try {
      userDetails = await _userApi.userMeGet();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      if (f.message == Constants.NO_INTERNET_CONNECTION) {
        userDetails =
            UserDetailsUtils.getMeFromLoggedInUserDetails(currentUser);
        setState(ViewState.Idle);
      } else {
        setErrorMessage(f.message);
        setState(ViewState.Error);
      }
    }
  }

  Future logout() async {
    setState(ViewState.Busy);
    try {
      await _userApi.userLogout();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }

  Future onLogoutTap() async {
    var _dialog = await _dialogService.showConfirmationDialog(
      title: "Log Out",
      description: "Are you sure you want to log out?",
      confirmationTitle: "LOGOUT",
    );

    if (_dialog.confirmed) {
      _dialogService.showCustomProgressDialog(title: "Logging You Out");
      await logout();
      _dialogService.dialogNavigationKey.currentState.pop();
      _pushNotificationService.fcm
          .unsubscribeFromTopic("release-" + currentUser.hostelCode);
      _navigationService.pushNamedAndRemoveUntil("login");
      isLoggedIn = false;
      token = null;
    }
  }
}
