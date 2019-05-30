//TODO api/user/password/ all three api calls

import 'dart:convert';
import 'package:appetizer/model/user/image.dart';
import 'package:appetizer/model/user/login.dart';
import 'package:appetizer/model/user/logout.dart';
import 'package:appetizer/model/user/me.dart';
import 'package:appetizer/model/user/password.dart';
import 'package:http/http.dart' as http;

String url = "http://appetizer-mdg.herokuapp.com";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<Login> apiUserLogin(String id, String pass) async {
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
    return login;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Logout> apiUserLogout(String token) async {
  String endpoint = "/api/user/logout/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.post(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Logout logout = new Logout.fromJson(jsonResponse);
    print(response.body);
    return logout;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
//TODO api User Me also has put and patch
Future<Me> apiUserMe(String token) async {
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

Future<Image> apiUserImage(String token) async {
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
Future<Password> apiUserPassword(String token, String oldPass, String newPass) async {
  String endpoint = "/api/user/me/password/";
  String uri = url + endpoint;
  var json={
    "old_password": oldPass,
    "new_password": newPass,
  };

  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.put(
      uri,
      headers: tokenAuth,
      body:  json,
    );
    final jsonResponse = jsonDecode(response.body);
    Password pass = new Password.fromJson(jsonResponse);
    print(response.body);
    return pass;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

//TODO It has a different tokenAuth
Future<Password> apiUserReset(String token, String email) async {
  String endpoint = "/api/user/me/password/reset/";
  String uri = url + endpoint;
  var json={
    "email" : email,
  };
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.post(
      uri,
      headers: tokenAuth,
      body:  json,
    );
    final jsonResponse = jsonDecode(response.body);
    Password pass = new Password.fromJson(jsonResponse);
    print(response.body);
    return pass;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}


