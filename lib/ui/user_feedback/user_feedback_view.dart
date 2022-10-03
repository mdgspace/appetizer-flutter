import 'package:appetizer/app_theme.dart';
import 'package:appetizer/models/feedback/appetizer_feedback.dart';
import 'package:appetizer/models/feedback/feedback_response.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/user_feedback/new_feedback_view.dart';
import 'package:appetizer/utils/feedback_utils.dart';
import 'package:appetizer/viewmodels/feedback/user_feedback_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserFeedbackView extends StatefulWidget {
  static const String id = 'user_feedback_view';

  @override
  _UserFeedbackViewState createState() => _UserFeedbackViewState();
}

class _UserFeedbackViewState extends State<UserFeedbackView> {
  bool _isInboxExpanded = false;
  bool _isSubmittedExpanded = false;

  Widget _buildResponse(FeedbackResponse response) {
    return ListTile(
      title: Text(
        response.message,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        DateFormat.yMMMMd().format(
          DateTime.fromMillisecondsSinceEpoch(response.dateCreated),
        ),
      ),
    );
  }

  Widget _buildFeedback(AppetizerFeedback feedback) {
    return ListTile(
      title: Text(
        feedback.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        FeedbackUtils.resolveFeedbackTypeCode(feedback.type) ??
            '' ' - #' + feedback.id.toString(),
      ),
      trailing: Text(
        DateFormat.yMMMMd().format(
          DateTime.fromMillisecondsSinceEpoch(feedback.dateIssue),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<UserFeedbackViewModel>(
      onModelReady: (model) async {
        await model.getResponseOfFeedbacks();
        await model.getSubmittedFeedbacks();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'Feedback'),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              ElevatedButton(
                onPressed: () => Get.toNamed(NewFeedbackView.id),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.edit,
                        color: AppTheme.primary,
                        size: 18.r,
                      ),
                      SizedBox(width: 12.r),
                      Text(
                        'New Feedback',
                        style: AppTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
              ExpansionTile(
                onExpansionChanged: (value) =>
                    setState(() => _isInboxExpanded = value),
                title: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(2.r),
                      child: Image.asset('assets/icons/inbox_logo.png'),
                    ),
                    SizedBox(width: 12.r),
                    Text(
                      'Inbox',
                      style: AppTheme.subtitle1.copyWith(
                        color: _isInboxExpanded
                            ? AppTheme.primary
                            : AppTheme.blackSecondary,
                      ),
                    ),
                  ],
                ),
                children: model.responseOfFeedbacks
                        ?.map((response) => _buildResponse(response))
                        ?.toList() ??
                    [],
              ),
              ExpansionTile(
                onExpansionChanged: (value) =>
                    setState(() => _isSubmittedExpanded = value),
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.send,
                      size: 16.r,
                      color: AppTheme.primary,
                    ),
                    SizedBox(width: 12.r),
                    Text(
                      'Submitted',
                      style: AppTheme.subtitle1.copyWith(
                        color: _isSubmittedExpanded
                            ? AppTheme.primary
                            : AppTheme.blackSecondary,
                      ),
                    ),
                  ],
                ),
                children: model.submittedFeedbacks
                        ?.map((feedback) => _buildFeedback(feedback))
                        ?.toList() ??
                    [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
