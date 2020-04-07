import 'package:appetizer/change_notifiers/year_and_month_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'leave_dropdown_filter.dart';
import 'leave_timeline.dart';

class MyLeavesHistory extends StatelessWidget {
  final String token;

  const MyLeavesHistory({Key key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => YearAndMonthModel(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: const Color.fromRGBO(255, 193, 7, 1),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(
            "Leave History",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
        ),
        body: SafeArea(
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: 80,
                  color: const Color.fromRGBO(241, 241, 241, 1),
                ),
                Positioned(
                  left: 79,
                  top: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: 1,
                    color: const Color.fromRGBO(0, 0, 0, 0.20),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    LeaveDropdownFilter(),
                    Flexible(
                      child: Container(
                        child: LeaveTimeline(
                          token: token,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
