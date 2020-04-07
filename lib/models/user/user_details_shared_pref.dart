import 'package:appetizer/utils/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsSharedPref {
  String _enrNo;
  String _username;
  String _token;
  String _branch;
  String _hostelName;
  String _roomNo;
  String _email;
  String _contactNo;

  String get enrNo => _enrNo;

  String get username => _username;

  String get token => _token;

  String get branch => _branch;

  String get hostelName => _hostelName;

  String get roomNo => _roomNo;

  String get email => _email;

  String get contactNo => _contactNo;

  UserDetailsSharedPref(SharedPreferences details) {
    _enrNo = details.getString("enrNo");
    _username = details.getString("username");
    _token = details.getString("token");
    _branch = details.getString("branch");
    _hostelName = details.getString("hostelName");
    _roomNo = details.getString("roomNo");
    _email = details.getString("email");
    _contactNo = details.getString("contactNo");
  }
  //TODO: Unify Login and UserDetails, they store similar data yet different classes

  UserDetailsSharedPref.fromData(
      this._enrNo,
      this._username,
      this._token,
      this._branch,
      this._hostelName,
      this._roomNo,
      this._email,
      this._contactNo);

  /// loads user details from SharedPreferences
  void loadUserDetails() {
    UserDetailsUtils.getUserDetails().then((details) async {
      _enrNo = details.getString("enrNo");
      _username = details.getString("username");
      _token = details.getString("token");
      _branch = details.getString("branch");
      _hostelName = details.getString("hostelName");
      _roomNo = details.getString("roomNo");
      _email = details.getString("email");
      _contactNo = details.getString("contactNo");
    });
  }
}
