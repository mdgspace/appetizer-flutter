import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/constants/env_config.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/feedback/appetizer_feedback.dart';
import 'package:appetizer/domain/models/feedback/feedback_response.dart';
import 'package:appetizer/domain/models/feedback/paginated_feedbacks.dart';
import 'package:appetizer/utils/api_utils.dart';
import 'package:flutter/foundation.dart';
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
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
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
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
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
      debugPrint(e.message);
      throw Failure(AppConstants.BAD_RESPONSE_FORMAT);
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}
