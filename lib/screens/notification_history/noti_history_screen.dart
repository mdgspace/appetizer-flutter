import 'package:flutter/material.dart';

import 'notification.dart';

class NotificationHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          color: const Color.fromRGBO(255, 193, 7, 1),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text("Notification History"),
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
      ),
      body: ListView(
        children: <Widget>[
          MessNotification('Timings Change', 'Today\'s dinner timings are 9-10 PM as there is an event scheduled by counselling cell in bhawan. So please co-operate', '7:52 PM, 19 Apr'),
          MessNotification('Timings Change', 'Today\'s dinner timings are 9-10 PM as there is an event scheduled by counselling cell in bhawan. So please co-operate', '7:52 PM, 19 Apr'),
          MessNotification('Timings Change', 'Today\'s dinner timings are 9-10 PM as there is an event scheduled by counselling cell in bhawan. So please co-operate', '7:52 PM, 19 Apr'),
          //TODO: IMPLEMENT MAP FOR THE NOTIFICATIONS FETCHED
        ],
      ),

    );
  }
}