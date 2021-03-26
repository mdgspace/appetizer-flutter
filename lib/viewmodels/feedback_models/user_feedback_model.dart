import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/feed_back/responses.dart';
import 'package:appetizer/models/feed_back/submitted_feedbacks.dart';
import 'package:appetizer/services/api/feedback.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class UserFeedbackModel extends BaseModel {
  FeedbackApi _feedbackApi = locator<FeedbackApi>();

  List<Response> _responseOfFeedbacks;

  List<Response> get responseOfFeedbacks => _responseOfFeedbacks;

  set responseOfFeedBacks(List<Response> responseOfFeedBacks) {
    _responseOfFeedbacks = responseOfFeedBacks;
    notifyListeners();
  }

  List<Feedbacks> _submittedFeedbacks;

  List<Feedbacks> get submittedFeedbacks => _submittedFeedbacks;

  set submittedFeedbacks(List<Feedbacks> submittedFeedbacks) {
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
