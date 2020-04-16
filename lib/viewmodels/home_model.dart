import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/navigation_service.dart';
import 'package:appetizer/services/push_notification_service.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeModel extends BaseModel {
  MultimessingApi _multimessingApi = locator<MultimessingApi>();
  UserApi _userApi = locator<UserApi>();
  PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  NavigationService _navigationService = locator<NavigationService>();

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

  Future logout() async {
    try {
      await _userApi.userLogout();
      _pushNotificationService.fcm
          .unsubscribeFromTopic("debug-" + currentUser.hostelCode);
      _navigationService.pushNamedAndRemoveUntil("login");
      currentUser = null;
      isLoggedIn = false;
      token = null;
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }

  Future onModelReady() async {
    await setSwitchableHostels();
    await fetchInitialCheckedStatus();
  }
}
