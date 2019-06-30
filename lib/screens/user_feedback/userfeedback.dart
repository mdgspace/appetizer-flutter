import 'package:appetizer/models/feed_back/submittedfeedbacks.dart';
import 'package:appetizer/models/feed_back/feedbacktypes.dart';
import 'package:appetizer/screens/user_feedback/newfeedback.dart';
import 'package:appetizer/timestampToDateTime.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appetizer/services/feed_back.dart';

import '../../colors.dart';

class UserFeedback extends StatefulWidget {
  @override
  _UserFeedbackState createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  Color color1 = Colors.black.withOpacity(0.7);
  Color color2 = Colors.black.withOpacity(0.7);
  List<Feedbacks> inbox;
  List<Feedbacks> submitted;
  List<Widget> inboxWidget;

  @override
  void initState() {
    super.initState();
    getLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: new Column(
        children: <Widget>[
          new RaisedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewFeedback()));
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
            children: inboxWidget,
          ),
        ],
      ),
    );
  }

  getLists() async {
    String token = await getToken();
    inbox = new List<Feedbacks>();
    inboxWidget = new List<Widget>();
    inbox = await submittedFeedBacks(token);
    inboxWidget = convertToWidget(inbox);
  }

  List<Widget> convertToWidget(List<Feedbacks> list) {
    List<Widget> temp = new List<Widget>();
    print(list);

    for (int i = list.length - 1; i >= 0; i--) {
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(list[i].dateIssue).toLocal();
      String feedbackTypeName = resolveFeedbackTypeCode(list[i].type);
      temp.add(new ListTile(
        title: new Text(
          list[i].title,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: new Text(feedbackTypeName + " - #" + list[i].id.toString()),
        trailing: new Text(date.day.toString() +
            "/" +
            date.month.toString() +
            "/" +
            date.year.toString().substring(2, 4)),
      ));
    }
    print(temp);
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

Widget feedbackList() {
  //String token = getToken();
}

Future<String> getToken() async {
  String token;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token");
  return token;
}
