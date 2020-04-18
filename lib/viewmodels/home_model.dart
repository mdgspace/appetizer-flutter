import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/dialog_models.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/version_check.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/api/version_check.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/services/navigation_service.dart';
import 'package:appetizer/services/push_notification_service.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeModel extends BaseModel {
  MultimessingApi _multimessingApi = locator<MultimessingApi>();
  UserApi _userApi = locator<UserApi>();
  VersionCheckApi _versionCheckApi = locator<VersionCheckApi>();
  PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  String _selectedHostel = "Your Meals";

  String get selectedHostel => _selectedHostel;

  set selectedHostel(String selectedHostel) {
    _selectedHostel = selectedHostel;
    notifyListeners();
  }

  List<String> _switchableHostelsList = ["Your Meals"];

  List<String> get switchableHostelsList => _switchableHostelsList;

  Future setSwitchableHostels() async {
    try {
      var switchableHostels = await _multimessingApi.switchableHostels();
      switchableHostels.forEach((hostel) {
        switchableHostelsList.add(hostel[2].toString());
      });
      notifyListeners();
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      Fluttertoast.showToast(msg: f.message);
    }
  }

  Future fetchInitialCheckedStatus() async {
    try {
      var userDetails = await _userApi.userMeGet();
      isCheckedOut = userDetails.isCheckedOut;
      notifyListeners();
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
    }
  }

  Future checkVersion() async {
    try {
      VersionCheck _versionCheck =
          await _versionCheckApi.checkVersion(appetizerVersion);
      if (_versionCheck.isExpired) {
        DialogResponse _dialogResponse =
            await _dialogService.showConfirmationDialog(
          title: "Current Version Expired",
          description:
              "Your Appetizer App is out of date. You need to update the app to continue!",
          confirmationTitle: "UPDATE",
        );
        if (_dialogResponse.confirmed) {
          if (await canLaunch(googlePlayLink)) {
            await launch(googlePlayLink);
          } else {
            throw 'Could not launch $googlePlayLink';
          }
        }
      }
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }

  Future onModelReady() async {
    await checkVersion();
    await setSwitchableHostels();
    await fetchInitialCheckedStatus();
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
