//TODO api/user/password/ all three api calls

import 'dart:convert';
import 'package:appetizer/model/menu/week.dart';
import 'package:appetizer/model/user/image.dart';
import 'package:appetizer/model/user/login.dart';
import 'package:appetizer/model/user/logout.dart';
import 'package:appetizer/model/user/me.dart';
import 'package:appetizer/model/user/password.dart';
import 'package:appetizer/model/user/reset.dart';
import 'package:http/http.dart' as http;


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
    return login;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Logout> userLogout(String token) async {
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
Future<Me> userMe(String token) async {
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
//TODO Confirm
Future<Password> userPassword(String token, String oldPass, String newPass) async {
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
Future<Reset> userReset(String token, String email) async {
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
    Reset reset = new Reset.fromJson(jsonResponse);
    print(response.body);
    return reset;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
//TODO Need to confirm
Future<Reset> userConfirm(String token, String uidB64, String token1, String newPass, String confirmPass) async {
  String endpoint = "/api/user/me/password/reset/confirm/";
  String uri = url + endpoint;
  var json={
    "uidb64" : uidB64,
    "token": token1,
    "new_password": newPass,
    "confirm_password": confirmPass,
  };
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.post(
      uri,
      headers: tokenAuth,
      body:  json,
    );
    final jsonResponse = jsonDecode(response.body);
    Reset reset = new Reset.fromJson(jsonResponse);
    print(response.body);
    return reset;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
//TODO Find the return type of redirect and complete and create respective model files
Future<Reset> oAuthRedirect(String token) async {
  String endpoint = "/api/user/oauth/redirect/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.post(
      uri,
      headers: tokenAuth,
      body:  json,
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
      body:  json,
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
Future<Week> menuWeek(String token) async {
  String endpoint = "/api/menu/week/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Week week = new Week.fromJson(jsonResponse);
    print(response.body);
    return week;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
Future<Week> menuWeekById(String token,String weekId,String year) async {
  String endpoint = "/api/menu/week/?week_id=$weekId&year=$year";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Week week = new Week.fromJson(jsonResponse);
    print(response.body);
    return week;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
Future<Day> menuDay(String token,String week,String dayOfWeek) async {
  String endpoint = "/api/menu/$week/$dayOfWeek";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Day day = new Day.fromJson(jsonResponse);
    print(response.body);
    return day;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
Future<Meal> menuMeal(String token,String week,String dayOfWeek,String meal) async {
  String endpoint = "/api/menu/$week/$dayOfWeek/$meal";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
   Meal meal= new Meal.fromJson(jsonResponse);
    print(response.body);
    return meal;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
Future<Meal> menuNextMeal(String token) async {
  String endpoint = "/api/menu/meal/next/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(
      uri,
      headers: tokenAuth,
    );
    final jsonResponse = jsonDecode(response.body);
    Meal meal= new Meal.fromJson(jsonResponse);
    print(response.body);
    return meal;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
//TODO meal/m/items:

Future<Meal> newMealItem(String token,String type,String name) async {
  String endpoint = "/api/menu/m/item/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  var json={
    "type": type,
    "name": name,
  };
  try {
    var response = await client.post(
      uri,
      headers: tokenAuth,
      body: json,
    );
    final jsonResponse = jsonDecode(response.body);
    Meal meal= new Meal.fromJson(jsonResponse);
    print(response.body);
    return meal;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
//TODO meal/m/week/ and week/approve