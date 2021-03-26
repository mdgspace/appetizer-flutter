import 'package:appetizer/locator.dart';
import 'package:appetizer/models/user/login.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/models/user/oauth.dart';
import 'package:appetizer/services/local_storage_service.dart';

class UserDetailsUtils {
  static Login getLoginModelFromMe(Me userDetails) {
    userDetails.toJson().addAll({
      "token": locator<LocalStorageService>().token,
      "is_new": locator<LocalStorageService>().currentUser.isNew,
    });
    return Login.fromJson(userDetails.toJson());
  }

  static Me getMeFromLoggedInUserDetails(Login login) {
    return Me.fromJson(login.toJson());
  }

  static Login getLoginFromStudentData(StudentData studentData, String token) {
    studentData.toJson().addAll({
      "token": token,
      "is_new": locator<LocalStorageService>().currentUser.isNew,
    });
    return Login.fromJson(studentData.toJson());
  }
}
