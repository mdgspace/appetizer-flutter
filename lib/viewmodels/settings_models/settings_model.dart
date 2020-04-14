import 'package:appetizer/constants.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/detail.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel extends BaseModel {
  UserApi _userApi = locator<UserApi>();

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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        userDetails = Me(
          email: prefs.getString("email"),
          name: prefs.getString("username"),
          enrNo: prefs.getInt("enrNo"),
          branch: prefs.getString("branch"),
          hostelName: prefs.getString("hostelName"),
          roomNo: prefs.getString("roomNo"),
          contactNo: prefs.getString("contactNo"),
        );
        setState(ViewState.Idle);
      } else {
        setErrorMessage(f.message);
        setState(ViewState.Error);
      }
    }
  }

  Future<bool> logout() async {
    setState(ViewState.Busy);
    try {
      FirebaseMessaging fcm = FirebaseMessaging();
      fcm.unsubscribeFromTopic("release-" + userDetails.hostelCode);
      userLogoutDetail = await _userApi.userLogout();
      setState(ViewState.Idle);
      if (userLogoutDetail.detail == "user logged out") return true;
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
      return false;
    }
    return false;
  }
}
