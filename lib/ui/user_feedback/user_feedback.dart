import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/feed_back/responses.dart';
import 'package:appetizer/models/feed_back/submitted_feedbacks.dart';
import 'package:appetizer/services/api/feedback.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/user_feedback/new_feedback.dart';
import 'package:appetizer/viewmodels/feedback_models/user_feedback_model.dart';
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
    return BaseView<UserFeedbackModel>(
      onModelReady: (model) {
        inboxWidget = new List<Widget>();
        submittedWidget = new List<Widget>();
        getLists(model);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: const Color.fromRGBO(255, 193, 7, 1),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(
            "Feedback",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
        ),
        body: SafeArea(
          child: new ListView(
            children: <Widget>[
              new RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewFeedback(),
                    ),
                  );
                },
                color: Colors.white,
                child: new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.edit,
                      color: appiYellow,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 25, top: 20, bottom: 20),
                      child: new Text(
                        "New Feedback",
                        style: new TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new ExpansionTile(
                onExpansionChanged: onExpansionChangedInbox,
                title: new Row(
                  children: <Widget>[
                    new Image.asset(
                      "assets/icons/inbox_logo.png",
                      height: 24,
                      width: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 25, top: 15, bottom: 15),
                      child: new Text(
                        "Inbox",
                        style: new TextStyle(
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
              new ExpansionTile(
                onExpansionChanged: onExpansionChangedSubmit,
                title: new Row(
                  children: <Widget>[
                    new Icon(
                      Icons.send,
                      size: 24,
                      color: appiYellow,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 25, top: 15, bottom: 15),
                      child: new Text(
                        "Submitted",
                        style: new TextStyle(
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

  getLists(UserFeedbackModel model) async {
    await model.getResponseOfFeedbacks();
    await model.getSubmittedFeedbacks();
    if (model.state != ViewState.Error) {
      setState(() {
        inboxWidget = convertToWidgetResponse(model.responseOfFeedbacks);
        submittedWidget = convertToWidgetFeedBack(model.submittedFeedbacks);
      });
    }
  }

  List<Widget> convertToWidgetResponse(List<Response> list) {
    List<Widget> temp = new List<Widget>();
    print(list);

    for (int i = list.length - 1; i >= 0; i--) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(list[i].dateCreated).toLocal();
      temp.add(new ListTile(
        title: new Text(
          list[i].message,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: new Text(date.day.toString() +
            "/" +
            date.month.toString() +
            "/" +
            date.year.toString().substring(2, 4)),
      ));
    }
    return temp;
  }

  List<Widget> convertToWidgetFeedBack(List<Feedbacks> list) {
    List<Widget> temp = new List<Widget>();

    for (int i = list.length - 1; i >= 0; i--) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(list[i].dateIssue).toLocal();
      String feedbackTypeName =
          FeedbackApi.resolveFeedbackTypeCode(list[i].type);
      temp.add(new ListTile(
        title: new Text(
          list[i].title,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle:
            new Text(feedbackTypeName ?? "" + " - #" + list[i].id.toString()),
        trailing: new Text(date.day.toString() +
            "/" +
            date.month.toString() +
            "/" +
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
