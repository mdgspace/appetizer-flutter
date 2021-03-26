import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/feed_back/feed_back.dart';
import 'package:appetizer/services/api/feedback.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/services/navigation_service.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class NewFeedbackModel extends BaseModel {
  FeedbackApi _feedbackApi = locator<FeedbackApi>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();

  Feedback _newFeedback;

  Feedback get newFeedback => _newFeedback;

  set newFeedback(Feedback newFeedback) {
    _newFeedback = newFeedback;
    notifyListeners();
  }

  Future postNewFeedback(String feedbackType, String title, String description,
      DateTime date) async {
    _dialogService.showCustomProgressDialog(title: "Sending Feedback");
    setState(ViewState.Busy);
    try {
      newFeedback = await _feedbackApi.newFeedBack(
          feedbackType, title, description, date);
      setState(ViewState.Idle);
      _dialogService.dialogNavigationKey.currentState.pop();
      showSnackBar(newFeedbackViewScaffoldKey, "Thank You For Your Feedback!");
      Future.delayed(Duration(seconds: 1), _navigationService.pop);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
      _dialogService.dialogNavigationKey.currentState.pop();
      showSnackBar(newFeedbackViewScaffoldKey, errorMessage);
    }
  }
}
