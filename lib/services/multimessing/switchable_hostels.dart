import 'dart:convert';

import 'package:appetizer/models/multimessing/switchable_hostels.dart';
import 'package:http/http.dart' as http;

String url = "https://mess.iitr.ac.in";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future switchableHostels(String token) async {
  String endPoint = "/api/user/multimessing/hostels";
  String uri = url + endPoint;
  var tokenAuth = {"Authorization": "Token " + token};

  try {
    var response = await client.get(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
    List<List<dynamic>> switchableHostels =
        switchableHostelsFromJson(jsonResponse);
    print(response.body);
    return switchableHostels;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
