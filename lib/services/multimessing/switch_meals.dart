import 'dart:convert';

import 'package:appetizer/models/multimessing/switch_meals_response.dart';
import 'package:http/http.dart' as http;

String url = "https://appetizer-mdg.herokuapp.com";
http.Client client = new http.Client();

Future<SwitchResponse> switchMeals(
    int mealId, String toHostel, String token) async {
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
    final jsonResponse = jsonDecode(response.body);
    SwitchResponse switchResponse = new SwitchResponse.fromJson(jsonResponse);
    print(switchResponse.secretCode);
    print(response.body);
    return switchResponse;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
