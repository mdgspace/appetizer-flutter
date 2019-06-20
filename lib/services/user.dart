import 'dart:convert';
import 'package:appetizer/models/detail.dart';
import 'package:http/http.dart' as http;
import 'package:appetizer/models/user/image.dart';
import 'package:appetizer/models/user/login.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/models/user/Notification.dart';

String url = "http://appetizer-mdg.herokuapp.com";
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

/*
Future<Me> userMePut(String token, Me me) async {
  String endpoint = "/api/user/me/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  var json=me.toJson();
  try {
    var response = await client.put(
      uri,
      headers: tokenAuth,
      body: json
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
*/
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

Future<Detail> userPassword(
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
/*
//TODO Find the return type of redirect and complete and create respective model files
Future<Reset> oAuthRedirect(String token) async {
  String endpoint = "/api/user/oauth/redirect/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.post(
      uri,
      headers: tokenAuth,
      body: json,
    );
    final jsonResponse = jsonDecode(response.body);
    //  Reset reset = new Reset.fromJson(jsonResponse);
    print(response.body);
    //  return reset;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Reset> oAuthComplete(String token) async {
  String endpoint = "/api/user/oauth/complete/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.post(
      uri,
      headers: tokenAuth,
      body: json,
    );
    final jsonResponse = jsonDecode(response.body);
    // Reset reset = new Reset.fromJson(jsonResponse);
    print(response.body);
    //return reset;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
*/

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
