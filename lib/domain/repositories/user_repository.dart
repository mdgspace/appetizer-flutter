import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/remote/api_service.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/user/notification.dart';
import 'package:appetizer/domain/models/user/oauth_user.dart';
import 'package:appetizer/domain/models/user/user.dart';

class UserRepository {
  ApiService _apiService;

  UserRepository(this._apiService);

  // TODO: check correct input params for all functions

  Future<User> userLogin(String username, String password) async {
    Map<String, dynamic> map = {
      'username': username,
      'password': password,
    };
    try {
      return await _apiService.login(map);
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future logout() async {
    try {
      return await _apiService.logout();
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<User> getCurrentUser() async {
    try {
      return await _apiService.getCurrentUser();
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<User> updateUser(User user) async {
    try {
      return await _apiService.updateUser(user);
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<User> updateFcmTokenForUser(User user) async {
    Map<String, dynamic> map = {
      // TODO: check if fcmToken is token or not
      'fcm_token': user.token,
    };
    try {
      return await _apiService.updateFcmTokenForUser(map);
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    Map<String, dynamic> map = {
      'old_password': oldPassword,
      'new_password': newPassword,
    };
    try {
      return await _apiService.changePassword(map);
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<void> sendResetPasswordLink(User user) async {
    Map<String, dynamic> map = {
      'email': user.email,
    };
    try {
      return await _apiService.resetPassword(map);
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<OAuthUser> oAuthRedirect(String code) async {
    try {
      return await _apiService.oAuthRedirect(code);
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<OAuthUser> oAuthComplete(OAuthUser user, String password) async {
    Map<String, dynamic> map = {
      'enr': user.studentData.enrNo,
      'password': password,
      'email': user.studentData.email,
      'contact_no': user.studentData.contactNo,
    };
    try {
      return await _apiService.oAuthComplete(map);
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<List<Notification>> getNotifications() async {
    try {
      return await _apiService.getNotifications();
    } catch (e) {
      print(e);
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}
