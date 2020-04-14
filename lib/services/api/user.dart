import 'dart:convert';
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
  var headers = {"Content-Type": "application/json"};
  http.Client client = new http.Client();

  Future<Login> userLogin(String id, String pass) async {
    String endpoint = "/api/user/login/";
    String uri = url + endpoint;
    var json = {
      "enr": id,
      "password": pass,
    };
    try {
      var jsonResponse = await ApiUtils.post(
        uri,
        headers: headers,
        body: jsonEncode(json),
      );
      Login login = new Login.fromJson(jsonResponse);
      return login;
    } on ForbiddenException {
      throw Failure(Constants.USER_AUTH_WRONG_CREDENTIALS);
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Detail> userLogout() async {
    String endpoint = "/api/user/logout/";
    String uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.post(
        uri,
        headers: headers,
      );
      Detail detail = new Detail.fromJson(jsonResponse);
      return detail;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<TokenStatus> checkTokenStatus() async {
    String endpoint = "/api/user/me/";
    String uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      if (jsonResponse["detail"] == "Invalid token.") {
        return TokenStatus.INVALID_TOKEN;
      }
      return TokenStatus.OK;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Me> userMeGet() async {
    String endpoint = "/api/user/me/";
    String uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      if (jsonResponse["detail"] == "Invalid token.") {
        return null;
      }
      Me me = new Me.fromJson(jsonResponse);
      return me;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Me> userMePatch(String email, String contactNo) async {
    String endpoint = "/api/user/me/";
    String uri = url + endpoint;
    var json = {
      "email": email,
      "contactNo": contactNo,
    };
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.patch(
        uri,
        headers: headers,
        body: jsonEncode(json),
      );
      Me me = new Me.fromJson(jsonResponse);
      return me;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Me> userMePatchFCM(String fcmToken) async {
    String endpoint = "/api/user/me/";
    String uri = url + endpoint;
    var json = {"fcm_token": fcmToken};
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.patch(
        uri,
        headers: headers,
        body: jsonEncode(json),
      );
      Me me = new Me.fromJson(jsonResponse);
      return me;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Image> userImage() async {
    String endpoint = "/api/user/me/image/";
    String uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(
        uri,
        headers: headers,
      );
      Image image = new Image.fromJson(jsonResponse);
      return image;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Detail> userPasswordReset(String oldPass, String newPass) async {
    String endpoint = "/api/user/me/password/";
    String uri = url + endpoint;
    var json = {
      "old_password": oldPass,
      "new_password": newPass,
    };

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.put(
        uri,
        headers: headers,
        body: json,
      );
      Detail detail = new Detail.fromJson(jsonResponse);
      return detail;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<Detail> userReset(String email) async {
    String endpoint = "/api/user/me/password/reset/";
    String uri = url + endpoint;
    var json = {
      "email": email,
    };
    try {
      var jsonResponse = await ApiUtils.post(
        uri,
        body: json,
      );
      Detail detail = new Detail.fromJson(jsonResponse);
      return detail;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future oAuthRedirect(String code) async {
    String endpoint = "/api/user/oauth/redirect/?code=$code";
    String uri = url + endpoint;
    try {
      var jsonResponse = await ApiUtils.get(
        uri,
      );
      OauthResponseNewUser newUserDetails =
          new OauthResponseNewUser.fromJson(jsonResponse);
      if (!newUserDetails.isNew) {
        OauthResponse userDetails = new OauthResponse.fromJson(jsonResponse);
        return userDetails;
      }
      return newUserDetails;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<OauthResponse> oAuthComplete(
      int enrNo, String password, String email, int contactNo) async {
    String endpoint = "/api/user/oauth/complete/";
    String uri = url + endpoint;
    print(url);
    var json = {
      "enr": enrNo,
      "password": password,
      "email": email,
      "contact_no": contactNo,
    };
    try {
      var jsonResponse = await ApiUtils.post(
        uri,
        headers: headers,
        body: jsonEncode(json),
      );
      OauthResponse userDetails = new OauthResponse.fromJson(jsonResponse);
      return userDetails;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<List<Result>> getNotifications() async {
    String endpoint = "/api/user/message/list/";
    String uri = url + endpoint;
    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      Notification notification = new Notification.fromJson(jsonResponse);
      return notification.results;
    } on FormatException {
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception {
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }
}
