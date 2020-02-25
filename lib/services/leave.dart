import 'dart:convert';
import 'package:appetizer/models/leaves/create_leave.dart';
import 'package:appetizer/models/leaves/check.dart';
import 'package:appetizer/models/leaves/leave_list.dart';
import 'package:appetizer/models/leaves/remaining_leave_count.dart';
import 'package:http/http.dart' as http;
import '../globals.dart';

var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<LeaveCount> remainingLeaves(String token) async {
  String endPoint = "/api/leave/count/remaining/";
  String uri = url + endPoint;
  var tokenAuth = {"Authorization": "Token " + token};

  try {
    var response = await client.get(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
    LeaveCount leaveCount = new LeaveCount.fromJson(jsonResponse);
    print(response.body);
    return leaveCount;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<LeaveList> leaveList(String token, int year, int month) async {
  String endPoint = "";
  if (month == 0) {
    endPoint = "/api/leave/all/?year=$year";
  } else {
    endPoint = "/api/leave/all/?year=$year&month=$month";
  }Future<LeaveCount> remainingLeaves(String token) async {
  String endPoint = "/api/leave/count/remaining/";
  String uri = url + endPoint;
  var tokenAuth = {"Authorization": "Token " + token};

  try {
    var response = await client.get(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
    LeaveCount leaveCount = new LeaveCount.fromJson(jsonResponse);
    print(response.body);
    return leaveCount;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
  String uri = url + endPoint;
  var tokenAuth = {"Authorization": "Token " + token};

  try {
    var response = await client.get(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
    LeaveList leaveList = new LeaveList.fromJson(jsonResponse);
    print(response.body);
    return leaveList;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Check> check(String token) async {
  String endPoint = "/api/leave/check/";
  String uri = url + endPoint;
  var tokenAuth = {"Authorization": "Token " + token};

  try {
    var response = await client.post(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
    Check check = new Check.fromJson(jsonResponse);
    print(response.body);
    return check;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<CreateLeave> leave(String id, String token) async {
  String endPoint = "/api/leave/";
  String uri = url + endPoint;
  var json = {
    "meal": id,
  };
  var tokenAuth = {"Authorization": "Token " + token};

  try {
    var response = await client.post(uri, headers: tokenAuth, body: json);
    final jsonResponse = jsonDecode(response.body);
    CreateLeave leave = new CreateLeave.fromJson(jsonResponse);
    print(response.body);
    return leave;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<bool> cancelLeave(int id, String token) async {
  String endPoint = "/api/leave/meal/$id";
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
