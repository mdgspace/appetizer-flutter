import 'package:appetizer/constants.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/leave_api.dart';
import 'package:appetizer/services/api/multimessing_api.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/services/api/version_check_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/services/push_notification_service.dart';
import 'package:appetizer/ui/login/login_view.dart';
import 'package:appetizer/utils/snackbar_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeViewModel extends BaseModel {
  final MultimessingApi _multimessingApi = locator<MultimessingApi>();
  final UserApi _userApi = locator<UserApi>();
  final LeaveApi _leaveApi = locator<LeaveApi>();
  final VersionCheckApi _versionCheckApi = locator<VersionCheckApi>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  final DialogService _dialogService = locator<DialogService>();

  bool _checkedOut = isCheckedOut;

  bool get checkedOut => _checkedOut;

  set checkedOut(bool isCheckedOut) {
    if (_checkedOut == isCheckedOut) {
      return;
    }
    _checkedOut = isCheckedOut;
    notifyListeners();
  }

  String _selectedHostel = 'Your Meals';

  String get selectedHostel => _selectedHostel;

  set selectedHostel(String selectedHostel) {
    _selectedHostel = selectedHostel;
    notifyListeners();
  }

  final List<String> _switchableHostelsList = ['Your Meals'];

  List<String> get switchableHostelsList => _switchableHostelsList;

  Future setSwitchableHostels() async {
    try {
      var switchableHostels = await _multimessingApi.switchableHostels();
      switchableHostels.forEach((hostel) {
        switchableHostelsList.add(hostel[2].toString());
      });
      notifyListeners();
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
      await Fluttertoast.showToast(msg: f.message);
    }
  }

  Future fetchInitialCheckedStatus() async {
    try {
      var userDetails = await _userApi.getCurrentUser();
      isCheckedOut = userDetails.isCheckedOut;
      notifyListeners();
    } on Failure catch (f) {
      if (f.message == Constants.UNAUTHORIZED_EXCEPTION) {
        await logoutAndClearData();
      }
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future checkVersion() async {
    try {
      var _versionCheck = await _versionCheckApi.checkVersion(appetizerVersion);
      if (_versionCheck.isExpired) {
        var _dialogResponse = await _dialogService.showConfirmationDialog(
          title: 'Current Version Expired',
          description:
              'Your Appetizer App is out of date. You need to update the app to continue!',
          confirmationTitle: 'UPDATE',
        );
        if (_dialogResponse.confirmed) {
          if (await canLaunchUrlString(appetizerLink)) {
            await launchUrlString(appetizerLink);
          } else {
            throw 'Could not launch $appetizerLink';
          }
        }
      }
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future logoutAndClearData() async {
    _dialogService.showCustomProgressDialog(title: 'Logging You Out');
    try {
      isLoggedIn = false;
      token = null;
      await _userApi.userLogout();
      await _pushNotificationService
          .unsubscribeFromTopic('${kReleaseMode ? 'release-' : 'debug-'}all');
      await _pushNotificationService.unsubscribeFromTopic(
          '${kReleaseMode ? 'release-' : 'debug-'}' + currentUser!.hostelCode);
      await Get.offAllNamed(LoginView.id);
      _dialogService.popDialog();
    } catch (e) {
      _dialogService.popDialog();
      SnackBarUtils.showDark(
          'Error', 'Unable to log you out. Please try after some time.');
    }
  }

  Future onLogoutTap() async {
    var _dialog = await _dialogService.showConfirmationDialog(
      title: 'Log Out',
      description: 'Are you sure you want to log out?',
      confirmationTitle: 'LOGOUT',
    );

    if (_dialog.confirmed) await logoutAndClearData();
  }

  Future checkout() async {
    try {
      isCheckedOut = await _leaveApi.checkout();
      notifyListeners();
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
    }
  }

  Future onCheckoutTap() async {
    if (isLeaveEnabled) {
      var dialogResponse = await _dialogService.showConfirmationDialog(
        title: 'Check Out',
        description: 'Are you sure you would like to check out?',
        confirmationTitle: 'CHECK OUT',
      );

      if (dialogResponse.confirmed) {
        await checkout();
        if (isCheckedOut) {
          SnackBarUtils.showDark('Info', 'You have checked out');
        }
      }
    } else {
      SnackBarUtils.showDark(
          'Info', 'Checkout through Appetizer is temporarily disabled!');
    }
  }
}
