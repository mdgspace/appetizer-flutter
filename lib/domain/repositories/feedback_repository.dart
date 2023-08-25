import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/services/remote/api_service.dart';
import 'package:appetizer/domain/models/failure_model.dart';
import 'package:appetizer/domain/models/feedback/appetizer_feedback.dart';
import 'package:appetizer/domain/models/feedback/feedback_response.dart';
import 'package:flutter/foundation.dart';

class FeedbackRepository {
  final ApiService _apiService;

  FeedbackRepository(this._apiService);

  Future<List<AppetizerFeedback>> submittedFeedbacks() async {
    try {
      return await _apiService.submittedFeedbacks();
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<List<FeedbackResponse>> responseOfFeedbacks() async {
    try {
      return await _apiService.responseOfFeedbacks();
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }

  Future<AppetizerFeedback> newFeedback(AppetizerFeedback feedback) async {
    Map<String, dynamic> map = {
      'type': feedback.type,
      'title': feedback.title,
      'message': feedback.message,
      'date_issue': feedback.dateIssue,
    };
    try {
      return await _apiService.newFeedback(map);
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(AppConstants.GENERIC_FAILURE);
    }
  }
}
