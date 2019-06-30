import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:appetizer/models/feed_back/submittedfeedbacks.dart';
import 'package:appetizer/models/feed_back/feedbacktypes.dart';

String url = "http://appetizer-mdg.herokuapp.com";
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

/*
Future<List<FeedbackType>> getFeedBackTypes(String token) async {
  String endpoint = "/api/feedback/all/";
  String uri = url + endpoint;
  var tokenAuth = {"Authorization": "Token " + token};
  try {
    var response = await client.get(uri, headers: tokenAuth);
    //var jsonResponse = jsonDecode(response.body);
    final feedbackType = feedbackTypeFromJson(response.body);
    print(response.body);
    return feedbackType;
  } on Exception catch (e) {
    print(e);
    return null;
  }
}
*/

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
