import 'package:flutter/material.dart';

import 'leave_status_card.dart';
import 'meal_left.dart';
import 'info_message.dart';
import 'manage_leaves_banner.dart';
import 'see_history.dart';
import 'package:appetizer/services/leave.dart';

class MyLeaves extends StatefulWidget {
  final String token;

  const MyLeaves({Key key, this.token}) : super(key: key);

  @override
  _MyLeavesState createState() => _MyLeavesState();
}

class _MyLeavesState extends State<MyLeaves> {
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color.fromRGBO(255, 193, 7, 1),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text(
          "My Leaves",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 262.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getRemainingLeaves(),
                ManageLeaveBanner(),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  //TODO: USE MAP FOR THE MEALS LEFT
                  MealLeft('Dinner', 'July 16 2019'),
                  MealLeft('Dinner', 'July 16 2019'),
                  MealLeft('Dinner', 'July 16 2019'),
                ],
              ),
            ),
          ),
          Container(
            height: 103.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InfoMessage(
                    'You can cancel your leave 2-3 hours before the meal'),
                SeeLeavesHistory(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getRemainingLeaves() {
    return FutureBuilder(
        future: remainingLeaves(widget.token),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return LeaveStatusCard(null);
          } else {
            return LeaveStatusCard(snapshot.data.count);
          }
        });
  }
}
