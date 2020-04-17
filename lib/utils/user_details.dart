import 'package:appetizer/locator.dart';
import 'package:appetizer/models/user/login.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/services/local_storage_service.dart';

class UserDetailsUtils {
  static Login getLoginModelFromMe(Me userDetails) {
    userDetails.toJson().addAll({
      "token": locator<LocalStorageService>().currentUser.token,
      "is_new": locator<LocalStorageService>().currentUser.isNew,
    });
    return Login.fromJson(userDetails.toJson());
  }

  static Me getMeFromLoggedInUserDetails(Login login) {
    return Me.fromJson(login.toJson());
  }
}
