import 'package:appetizer/globals.dart';
import 'package:appetizer/viewmodels/year_and_month_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'leave_dropdown_filter.dart';
import 'leave_timeline.dart';

class MyLeavesHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => YearAndMonthModel(),
      child: Scaffold(
        key: leavesHistoryViewScaffoldKey,
        appBar: AppBar(
          title: Text(
            'Leave History',
            style: TextStyle(color: Colors.white),
          ),
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
                        child: LeaveTimeline(),
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
