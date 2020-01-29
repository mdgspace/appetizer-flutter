import 'package:flutter/material.dart';

import 'notification.dart';
import 'package:appetizer/services/user.dart';
import 'package:appetizer/colors.dart';

import 'package:appetizer/utils/time_stamp_to_date_time.dart';

class NotificationHistory extends StatelessWidget {
  final String token;

  const NotificationHistory({Key key, this.token}) : super(key: key);

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
            "Notification History",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
        ),
        body: SafeArea(child: notificationList()));
  }

  Widget notificationList() {
    return FutureBuilder(
        future: getNotifications(token),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(appiYellow),
              )),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return MessNotification(
                      snapshot.data[index].title,
                      snapshot.data[index].message,
                      dateTime(snapshot.data[index].dateCreated));
                });
          }
        });
  }
}
