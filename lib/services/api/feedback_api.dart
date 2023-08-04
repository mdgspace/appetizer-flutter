import 'package:appetizer_revamp_parts/config/environment_config.dart';
import 'package:appetizer_revamp_parts/constants.dart';
import 'package:appetizer_revamp_parts/models/failure_model.dart';
import 'package:appetizer_revamp_parts/models/feedback/appetizer_feedback.dart';
import 'package:appetizer_revamp_parts/models/feedback/feedback_response.dart';
import 'package:appetizer_revamp_parts/models/feedback/paginated_feedbacks.dart';
import 'package:appetizer_revamp_parts/utils/api_utils.dart';
import 'package:http/http.dart' as http;

class FeedbackApi {
  var headers = {'Content-Type': 'application/json'};
  http.Client client = http.Client();

  Future<List<AppetizerFeedback>> submittedFeedBacks() async {
    var endpoint = '/api/feedback/all/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var paginatedFeedbacks = PaginatedFeedbacks.fromJson(jsonResponse);
      return paginatedFeedbacks.feedbacks;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<List<FeedbackResponse>> responseOfFeedBacks() async {
    var endpoint = '/api/feedback/response/list/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.get(uri, headers: headers);
      var feedbackResponses = List<FeedbackResponse>.from(
        jsonResponse.map((x) => FeedbackResponse.fromJson(x)),
      );
      return feedbackResponses;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }

  Future<AppetizerFeedback> newFeedBack(
      String type, String title, String message, DateTime dateIssue) async {
    var endpoint = '/api/feedback/';
    var uri = EnvironmentConfig.BASE_URL + endpoint;
    var json = {
      'type': type,
      'title': title,
      'message': message,
      'date_issue': dateIssue.millisecondsSinceEpoch.toString()
    };

    try {
      await ApiUtils.addTokenToHeaders(headers);
      var jsonResponse = await ApiUtils.post(uri, headers: headers, body: json);
      var feedback = AppetizerFeedback.fromJson(jsonResponse);
      return feedback;
    } on FormatException catch (e) {
      print(e.message);
      throw Failure(Constants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      print(e.toString());
      throw Failure(Constants.GENERIC_FAILURE);
    }
  }
}
