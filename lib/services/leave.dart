import 'dart:convert';
import 'package:appetizer/models/leaves/check.dart';
import 'package:appetizer/models/leaves/leave.dart';
import 'package:appetizer/models/leaves/leaveList.dart';
import 'package:appetizer/models/leaves/remainingLeaveCount.dart';
import 'package:http/http.dart' as http;

String url = "http://appetizer-mdg.herokuapp.com";
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

Future<LeaveList> leaveList(String token) async {
  String endPoint = "/api/leave/all/";
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

Future<Leave> leave(int id, String token) async {
  String endPoint = "/api/leave/";
  String uri = url + endPoint;
  var json = {
    "meal": id,
  };
  var tokenAuth = {"Authorization": "Token " + token};

  try {
    var response = await client.post(uri, headers: tokenAuth, body: json);
    final jsonResponse = jsonDecode(response.body);
    Leave leave = new Leave.fromJson(jsonResponse);
    print(response.body);
    return leave;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

