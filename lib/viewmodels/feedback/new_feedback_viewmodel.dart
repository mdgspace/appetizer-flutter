import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/feedback/appetizer_feedback.dart';
import 'package:appetizer/services/api/feedback_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/utils/snackbar_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewFeedbackViewModel extends BaseModel {
  final FeedbackApi _feedbackApi = locator<FeedbackApi>();
  final DialogService _dialogService = locator<DialogService>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late AppetizerFeedback _feedback;

  AppetizerFeedback get feedback => _feedback;

  set feedback(AppetizerFeedback feedback) {
    _feedback = feedback;
    notifyListeners();
  }

  Future addFeedback(String feedbackType, DateTime date) async {
    _dialogService.showCustomProgressDialog(title: 'Sending Feedback');
    setState(ViewState.Busy);
    try {
      feedback = await _feedbackApi.newFeedBack(
        feedbackType,
        titleController.text.trim(),
        descriptionController.text.trim(),
        date,
      );
      setState(ViewState.Idle);
      _dialogService.popDialog();
      titleController.text = '';
      descriptionController.text = '';
      SnackBarUtils.showDark('Info', 'Thank You For Your Feedback!');
      await Future.delayed(Duration(seconds: 1));
      Get.back();
    } on Failure catch (f) {
      _dialogService.popDialog();
      setState(ViewState.Error);
      setErrorMessage(f.message);
      SnackBarUtils.showDark('Error', errorMessage);
    }
  }
}
