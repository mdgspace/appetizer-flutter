import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/feedback/appetizer_feedback.dart';
import 'package:appetizer/models/feedback/feedback_response.dart';
import 'package:appetizer/services/api/feedback_api.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class UserFeedbackViewModel extends BaseModel {
  final FeedbackApi _feedbackApi = locator<FeedbackApi>();

  List<FeedbackResponse>? _responseOfFeedbacks;

  List<FeedbackResponse>? get responseOfFeedbacks => _responseOfFeedbacks;

  set responseOfFeedBacks(List<FeedbackResponse>? responseOfFeedBacks) {
    _responseOfFeedbacks = responseOfFeedBacks;
    notifyListeners();
  }

  List<AppetizerFeedback>? _submittedFeedbacks;

  List<AppetizerFeedback>? get submittedFeedbacks => _submittedFeedbacks;

  set submittedFeedbacks(List<AppetizerFeedback>? submittedFeedbacks) {
    _submittedFeedbacks = submittedFeedbacks;
    notifyListeners();
  }

  Future getResponseOfFeedbacks() async {
    setState(ViewState.Busy);
    try {
      responseOfFeedBacks = await _feedbackApi.responseOfFeedBacks();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }

  Future getSubmittedFeedbacks() async {
    setState(ViewState.Busy);
    try {
      submittedFeedbacks = await _feedbackApi.submittedFeedBacks();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
