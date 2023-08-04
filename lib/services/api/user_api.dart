import 'package:appetizer_revamp_parts/config/environment_config.dart';
import 'package:appetizer_revamp_parts/constants.dart';
import 'package:appetizer_revamp_parts/models/failure_model.dart';
import 'package:appetizer_revamp_parts/models/user/oauth_user.dart';
import 'package:appetizer_revamp_parts/models/user/paginated_notifications.dart';
import 'package:appetizer_revamp_parts/models/user/user.dart';
import 'package:appetizer_revamp_parts/utils/api_utils.dart';
import 'package:appetizer_revamp_parts/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:appetizer_revamp_parts/models/user/notification.dart';

class UserApi {
  var headers = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<User> userLogin(String id, String pass) async {
    var endpoint = '/api/user/login/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    var json = {
      'enr': id,
      'password': pass,
    };

    try {
      var jsonResponse = await ApiUtils.post(uri, headers: headers, body: json);
      var user = User.fromJson(jsonResponse);
      return user;
    } on ForbiddenException catch (e) {
      print(e.message);
      throw Failure(Constants.USER_AUTH_WRONG_CREDENTIALS);
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future userLogout() async {
    var endpoint = '/api/user/logout/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      await ApiUtils.post(uri, headers: headers);
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<User> getCurrentUser() async {
    var endpoint = '/api/user/me/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      var user = User.fromJson(jsonResponse);
      return user;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<User> updateUser(String email, String contactNo) async {
    var endpoint = '/api/user/me/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    var json = {
      'email': email,
      'contact_no': contactNo,
    };

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.patch(
        uri,
        headers: headers,
        body: json,
      );
      var user = User.fromJson(jsonResponse);
      return user;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<User> updateFcmTokenForUser(String fcmToken) async {
    var endpoint = '/api/user/me/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    var json = {'fcm_token': fcmToken};

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.patch(
        uri,
        headers: headers,
        body: json,
      );
      var user = User.fromJson(jsonResponse);
      return user;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future resetUserPassword(String oldPassword, String newPassword) async {
    var endpoint = '/api/user/me/password/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    var json = {
      'old_password': oldPassword,
      'new_password': newPassword,
    };

    try {
      await ApiUtils.addTokenToHeaders(headers);
      await ApiUtils.put(uri, headers: headers, body: json);
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future sendResetPasswordLink(String email) async {
    var endpoint = '/api/user/me/password/reset/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    var json = {'email': email};
    final headers = {'Content-Type': 'application/json'};

    try {
      await ApiUtils.post(uri, headers: headers, body: json);
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<OAuthUser> oAuthRedirect(String code) async {
    var endpoint = '/api/user/oauth/omniport/redirect/?code=$code';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    try {
      var jsonResponse = await ApiUtils.get(uri);
      var oauthUser = OAuthUser.fromJson(jsonResponse);
      return oauthUser;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<OAuthUser> oAuthComplete(
      int enrNo, String password, String email, int contactNo) async {
    var endpoint = '/api/user/oauth/complete/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    var json = {
      'enr': enrNo,
      'password': password,
      'email': email,
      'contact_no': contactNo,
    };

    try {
      var jsonResponse = await ApiUtils.post(uri, headers: headers, body: json);
      var oauthUser = OAuthUser.fromJson(jsonResponse);
      return oauthUser;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<List<Notification>> getNotifications() async {
    var endpoint = '/api/user/message/list/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var paginatedNotifications =
          PaginatedNotifications.fromJson(jsonResponse);
      return paginatedNotifications.results;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }
}
