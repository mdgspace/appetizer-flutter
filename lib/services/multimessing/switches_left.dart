import 'dart:convert';

import 'package:appetizer/models/multimessing/LeaveAndSwitchCount.dart';
import 'package:http/http.dart' as http;

import '../../globals.dart';

http.Client client = new http.Client();

Future<LeaveAndSwitchCount> remainingSwitches(String token) async {
  String endPoint = "/api/leave/switch/count/remaining/";
  String uri = url + endPoint;
  var tokenAuth = {"Authorization": "Token " + token};

  try {
    var response = await client.get(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
    LeaveAndSwitchCount leaveAndSwitchCount =
        new LeaveAndSwitchCount.fromJson(jsonResponse);
    print(response.body);
    return leaveAndSwitchCount;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
