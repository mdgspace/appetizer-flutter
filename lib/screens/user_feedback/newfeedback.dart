import 'package:flutter/material.dart';
import 'package:appetizer/services/feed_back.dart';

import '../../colors.dart';

class NewFeedback extends StatefulWidget {
  @override
  _NewFeedbackState createState() => _NewFeedbackState();
}

class _NewFeedbackState extends State<NewFeedback> {
  List<String> _feedbackType = ["gn", "am", "hc", "tm", "wm", "ws", "dn"];

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
          "New Feedback",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: new Icon(
              Icons.attachment,
              color: appiYellow,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 20),
            child: new Icon(
              Icons.send,
              color: appiYellow,
            ),
          ),
        ],
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
      ),
      body: Center(
        child: new Column(
          children: <Widget>[
            Container(
              child: new TextField(
                decoration: InputDecoration(labelText: "Title"),
              ),
              width: 350,
            ),
            Container(
              width: 350,
              child: new DropdownButtonFormField(
                  items: _feedbackType.map((value) {
                return new DropdownMenuItem(
                    child: new Text(resolveFeedbackTypeCode(value)));
              }).toList()),
            )
          ],
        ),
      ),
    );
  }
}
