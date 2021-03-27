import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/feedback/appetizer_feedback.dart';
import 'package:appetizer/models/feedback/feedback_response.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/user_feedback/new_feedback.dart';
import 'package:appetizer/utils/feedback_utils.dart';
import 'package:appetizer/viewmodels/feedback/user_feedback_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/colors.dart';

class UserFeedback extends StatefulWidget {
  @override
  _UserFeedbackState createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  Color color1 = Colors.black.withOpacity(0.7);
  Color color2 = Colors.black.withOpacity(0.7);
  List<Widget> submittedWidget;
  List<Widget> inboxWidget;

  @override
  Widget build(BuildContext context) {
    return BaseView<UserFeedbackViewModel>(
      onModelReady: (model) {
        inboxWidget = <Widget>[];
        submittedWidget = <Widget>[];
        getLists(model);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Feedback',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewFeedback(),
                    ),
                  );
                },
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.edit,
                      color: appiYellow,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 25, top: 20, bottom: 20),
                      child: Text(
                        'New Feedback',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ExpansionTile(
                onExpansionChanged: onExpansionChangedInbox,
                title: Row(
                  children: <Widget>[
                    Image.asset(
                      'assets/icons/inbox_logo.png',
                      height: 24,
                      width: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 25, top: 15, bottom: 15),
                      child: Text(
                        'Inbox',
                        style: TextStyle(
                          color: color1,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                children: <Widget>[
                  Container(
                    height: inboxWidget.length * 60.toDouble(),
                    child: ListView(
                      children: inboxWidget,
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                onExpansionChanged: onExpansionChangedSubmit,
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.send,
                      size: 24,
                      color: appiYellow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 25, top: 15, bottom: 15),
                      child: Text(
                        'Submitted',
                        style: TextStyle(
                          color: color2,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                children: <Widget>[
                  Container(
                    height: submittedWidget.length * 60.toDouble() + 20,
                    child: ListView(
                      children: submittedWidget,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getLists(UserFeedbackViewModel model) async {
    await model.getResponseOfFeedbacks();
    await model.getSubmittedFeedbacks();
    if (model.state != ViewState.Error) {
      setState(() {
        inboxWidget = convertToWidgetResponse(model.responseOfFeedbacks);
        submittedWidget = convertToWidgetFeedBack(model.submittedFeedbacks);
      });
    }
  }

  List<Widget> convertToWidgetResponse(List<FeedbackResponse> list) {
    var temp = <Widget>[];
    print(list);

    for (var i = list.length - 1; i >= 0; i--) {
      var date =
          DateTime.fromMillisecondsSinceEpoch(list[i].dateCreated).toLocal();
      temp.add(ListTile(
        title: Text(
          list[i].message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(date.day.toString() +
            '/' +
            date.month.toString() +
            '/' +
            date.year.toString().substring(2, 4)),
      ));
    }
    return temp;
  }

  List<Widget> convertToWidgetFeedBack(List<AppetizerFeedback> list) {
    var temp = <Widget>[];

    for (var i = list.length - 1; i >= 0; i--) {
      var date =
          DateTime.fromMillisecondsSinceEpoch(list[i].dateIssue).toLocal();
      var feedbackTypeName =
          FeedbackUtils.resolveFeedbackTypeCode(list[i].type);
      temp.add(ListTile(
        title: Text(
          list[i].title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(feedbackTypeName ?? '' ' - #' + list[i].id.toString()),
        trailing: Text(date.day.toString() +
            '/' +
            date.month.toString() +
            '/' +
            date.year.toString().substring(2, 4)),
      ));
    }
    return temp;
  }

  void onExpansionChangedInbox(bool value) {
    if (value) {
      setState(() {
        color1 = appiYellow;
      });
    } else {
      setState(() {
        color1 = Colors.black.withOpacity(0.7);
      });
    }
  }

  void onExpansionChangedSubmit(bool value) {
    if (value) {
      setState(() {
        color2 = appiYellow;
      });
    } else {
      setState(() {
        color2 = Colors.black.withOpacity(0.7);
      });
    }
  }
}
