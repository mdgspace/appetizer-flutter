import 'package:appetizer/constants.dart';
import 'package:appetizer/enums/token_status.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/detail.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/oauth.dart';
import 'package:appetizer/models/user/oauth_new_user.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:appetizer/utils/app_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:appetizer/models/user/image.dart';
import 'package:appetizer/models/user/login.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/models/user/notification.dart';

class UserApi {
  var headers = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<Login> userLogin(String id, String pass) async {
    var endpoint = '/api/user/login/';
    var uri = url + endpoint;
    var json = {
      'enr': id,
      'password': pass,
    };
    try {
      var jsonResponse = await ApiUtils.post(
        uri,
        headers: headers,
        body: json,
      );
      var login = Login.fromJson(jsonResponse);
      return login;
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

  Future<Detail> userLogout() async {
    var endpoint = '/api/user/logout/';
    var uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.post(
        uri,
        headers: headers,
      );
      var detail = Detail.fromJson(jsonResponse);
      return detail;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<TokenStatus> checkTokenStatus() async {
    var endpoint = '/api/user/me/';
    var uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      if (jsonResponse['detail'] == 'Invalid token.') {
        return TokenStatus.INVALID_TOKEN;
      }
      return TokenStatus.OK;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Me> userMeGet() async {
    var endpoint = '/api/user/me/';
    var uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      if (jsonResponse['detail'] == 'Invalid token.') {
        return null;
      }
      var me = Me.fromJson(jsonResponse);
      return me;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Me> userMePatch(String email, String contactNo) async {
    var endpoint = '/api/user/me/';
    var uri = url + endpoint;
    var json = {
      'email': email,
      'contactNo': contactNo,
    };
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.patch(
        uri,
        headers: headers,
        body: json,
      );
      var me = Me.fromJson(jsonResponse);
      return me;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Me> userMePatchFCM(String fcmToken) async {
    var endpoint = '/api/user/me/';
    var uri = url + endpoint;
    var json = {'fcm_token': fcmToken};
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.patch(
        uri,
        headers: headers,
        body: json,
      );
      var me = Me.fromJson(jsonResponse);
      return me;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Image> userImage() async {
    var endpoint = '/api/user/me/image/';
    var uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      var image = Image.fromJson(jsonResponse);
      return image;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Detail> userPasswordReset(String oldPass, String newPass) async {
    var endpoint = '/api/user/me/password/';
    var uri = url + endpoint;
    var json = {
      'old_password': oldPass,
      'new_password': newPass,
    };

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.put(
        uri,
        headers: headers,
        body: json,
      );
      var detail = Detail.fromJson(jsonResponse);
      return detail;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Detail> userReset(String email) async {
    var endpoint = '/api/user/me/password/reset/';
    var uri = url + endpoint;
    var json = {
      'email': email,
    };
    try {
      var jsonResponse = await ApiUtils.post(
        uri,
        body: json,
      );
      var detail = Detail.fromJson(jsonResponse);
      return detail;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future oAuthRedirect(String code) async {
    var endpoint = '/api/user/oauth/redirect/?code=$code';
    var uri = url + endpoint;
    try {
      var jsonResponse = await ApiUtils.get(
        uri,
      );
      var newUserDetails =
          OauthResponseNewUser.fromJson(jsonResponse);
      if (!newUserDetails.isNew) {
        var userDetails = OauthResponse.fromJson(jsonResponse);
        return userDetails;
      }
      return newUserDetails;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<OauthResponse> oAuthComplete(
      int enrNo, String password, String email, int contactNo) async {
    var endpoint = '/api/user/oauth/complete/';
    var uri = url + endpoint;
    print(url);
    var json = {
      'enr': enrNo,
      'password': password,
      'email': email,
      'contact_no': contactNo,
    };
    try {
      var jsonResponse = await ApiUtils.post(
        uri,
        headers: headers,
        body: json,
      );
      var userDetails = OauthResponse.fromJson(jsonResponse);
      return userDetails;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<List<Result>> getNotifications() async {
    var endpoint = '/api/user/message/list/';
    var uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var notification = Notification.fromJson(jsonResponse);
      return notification.results;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }
}
