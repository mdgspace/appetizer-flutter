import 'dart:convert';

import 'package:http/http.dart' as http;

String url = "https://appetizer-mdg.herokuapp.com";
http.Client client = new http.Client();

Future<bool> switchMeals(int mealId, String toHostel, String token) async {
  String endPoint = "/api/leave/switch/";
  String uri = url + endPoint;
  var json = {
    "from_meal": mealId,
    "to_hostel": toHostel,
  };
  var headers = {
    "Authorization": "Token " + token,
    "Content-Type": "application/json",
  };

  try {
    var response =
        await client.post(uri, headers: headers, body: jsonEncode(json));
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<bool> cancelSwitch(int id, String token) async {
  String endPoint = "/api/leave/switch/$id";
  String uri = url + endPoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    final response = await client.delete(uri, headers: tokenAuth);
    if (response.statusCode >= 200 && response.statusCode < 210) {
      return true;
    }
    return false;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<String> getQRData(int id, String token) async {
  String endpoint = "/api/leave/switch/meal/$id";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token $token"};
  try {
    final response = await client.get(uri, headers: tokenAuth);
    String secretCode = response.body;
    return secretCode;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
