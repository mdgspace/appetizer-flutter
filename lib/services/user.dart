import 'dart:convert';
import 'package:appetizer/models/detail.dart';
import 'package:appetizer/models/user/oauth.dart';
import 'package:appetizer/models/user/oauth_new_user.dart';
import 'package:http/http.dart' as http;
import 'package:appetizer/models/user/image.dart';
import 'package:appetizer/models/user/login.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/models/user/notification.dart';

String url = "https://appetizer-mdg.herokuapp.com";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<Login> userLogin(String id, String pass) async {
  String endpoint = "/api/user/login/";
  String uri = url + endpoint;
  var json = {
    "enr": id,
    "password": pass,
  };
  try {
    var response = await client.post(
      uri,
      headers: header,
      body: jsonEncode(json),
    );
    final jsonResponse = jsonDecode(response.body);
    Login login = new Login.fromJson(jsonResponse);
    print(response.body);
    if (response.body.isNotEmpty) {
      return login;
    }
    return null;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Detail> userLogout(String token) async {
  String endpoint = "/api/user/logout/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.post(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Detail detail = new Detail.fromJson(jsonResponse);
    print(response.body);
    print(jsonEncode(tokenAuth));
    return detail;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Me> userMeGet(String token) async {
  String endpoint = "/api/user/me/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Me me = new Me.fromJson(jsonResponse);
    print(response.body);
    return me;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Me> userMePatch(String token, String email, String contactNo) async {
  String endpoint = "/api/user/me/";
  String uri = url + endpoint;
  var json = {
    "email": email,
    "contactNo": contactNo,
  };
  var tokenAuth = {
    "Authorization": "Token " + token,
    "Content-Type": "application/json"
  };
  try {
    var response = await client.patch(
      uri,
      headers: tokenAuth,
      body: jsonEncode(json),
    );
    final jsonResponse = jsonDecode(response.body);
    Me me = new Me.fromJson(jsonResponse);
    print(response.body);
    return me;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Me> userMePatchFCM(String token, String fcmToken) async {
  String endpoint = "/api/user/me/";
  String uri = url + endpoint;
  var json = {"fcm_token": fcmToken};
  var tokenAuth = {
    "Authorization": "Token " + token,
    "Content-Type": "application/json"
  };
  try {
    var response = await client.patch(
      uri,
      headers: tokenAuth,
      body: jsonEncode(json),
    );
    final jsonResponse = jsonDecode(response.body);
    Me me = new Me.fromJson(jsonResponse);
    print(response.body);
    return me;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Image> userImage(String token) async {
  String endpoint = "/api/user/me/image/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Image image = new Image.fromJson(jsonResponse);
    print(response.body);
    return image;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Detail> userPasswordReset(
    String token, String oldPass, String newPass) async {
  String endpoint = "/api/user/me/password/";
  String uri = url + endpoint;
  var json = {
    "old_password": oldPass,
    "new_password": newPass,
  };

  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.put(
      uri,
      headers: tokenAuth,
      body: json,
    );
    final jsonResponse = jsonDecode(response.body);
    Detail detail = new Detail.fromJson(jsonResponse);
    print(response.body);
    return detail;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Detail> userReset(String email) async {
  String endpoint = "/api/user/me/password/reset/";
  String uri = url + endpoint;
  var json = {
    "email": email,
  };
  try {
    var response = await client.post(
      uri,
      body: json,
    );
    final jsonResponse = jsonDecode(response.body);
    Detail detail = new Detail.fromJson(jsonResponse);
    print(response.body);
    return detail;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future oAuthRedirect(String code) async {
  String endpoint = "/api/user/oauth/redirect/?code=$code";
  String uri = "https://mess.iitr.ac.in" + endpoint;
  try {
    var response = await client.get(
      uri,
    );
    final jsonResponse = jsonDecode(response.body);
    OauthResponseNewUser newUserDetails =
        new OauthResponseNewUser.fromJson(jsonResponse);
    if (!newUserDetails.isNew) {
      OauthResponse userDetails = new OauthResponse.fromJson(jsonResponse);
      return userDetails;
    }
    return newUserDetails;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<OauthResponse> oAuthComplete(
    int enrNo, String password, String email, int contactNo) async {
  String endpoint = "/api/user/oauth/complete/";
  String uri = "https://mess.iitr.ac.in" + endpoint;
  print(url);
  var json = {
    "enr": enrNo,
    "password": password,
    "email": email,
    "contact_no": contactNo,
  };
  print(jsonEncode(json));
  try {
    var response = await client.post(
      uri,
      headers: header,
      body: jsonEncode(json),
    );
    final jsonResponse = jsonDecode(response.body);
    print(response.body);
    OauthResponse userDetails = new OauthResponse.fromJson(jsonResponse);
    print(userDetails.token);
    return userDetails;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<List<Result>> getNotifications(String token) async {
  String endpoint = "/api/user/message/list/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
    Notification notification = new Notification.fromJson(jsonResponse);
    print(response.body);
    return notification.results;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
