import 'dart:convert';

import 'package:appetizer/models/feed_back/feed_back.dart';
import 'package:appetizer/models/feed_back/responses.dart';
import 'package:appetizer/models/feed_back/submitted_feedbacks.dart';
import 'package:http/http.dart' as http;

String url = "https://appetizer-mdg.herokuapp.com";
var header = {"Content-Type": "application/json"};
http.Client client = new http.Client();

Future<List<Feedbacks>> submittedFeedBacks(String token) async {
  String endpoint = "/api/feedback/all/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(uri, headers: tokenAuth);
    final jsonResponse = jsonDecode(response.body);
    SubmittedFeedbacksList list =
        new SubmittedFeedbacksList.fromJson(jsonResponse);
    print(response.body);
    return list.feedbacks;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<List<Response>> responseOfFeedBacks(String token) async {
  String endpoint = "/api/feedback/response/list/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(uri, headers: tokenAuth);
    List<Response> list = responseFromJson(response.body);
    return list;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

Future<Feedback> newFeedBack(String token, String type, String title,
    String message, DateTime dateIssue) async {
  String endpoint = "/api/feedback/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  var json = {
    "type": type,
    "title": title,
    "message": message,
    "date_issue": dateIssue.millisecondsSinceEpoch.toString()
  };
  try {
    var response = await client.post(uri, headers: tokenAuth, body: json);
    final jsonResponse = jsonDecode(response.body);
    Feedback feedback = new Feedback.fromJson(jsonResponse);
    print(response.body);
    return feedback;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}

resolveFeedbackTypeCode(String str) {
  switch (str) {
    case "gn":
      return "General";
    case "am":
      return "Ambience";
    case "hc":
      return "Hygiene and Cleanliness";
    case "tm":
      return "Mess Timings";
    case "wm":
      return "Weekly Menu";
    case "ws":
      return "Worker and Services";
    case "dn":
      return "Diet and Nutrition";
  }
}
