import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';
import '../../selectedYearAndMonthModelForLeaveHistory.dart';
import 'data_classes.dart';
import 'month_timeline.dart';
import 'package:appetizer/services/leave.dart';
import 'package:appetizer/helper_methods/monthStringToMonthInt.dart';

class LeaveTimeline extends StatelessWidget {
  final String token;

  const LeaveTimeline({Key key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final currentMonthAndYear = Provider.of<YearAndMonthModel>(context);

    return FutureBuilder(
      future: leaveList(token, currentMonthAndYear.currentYearSelected,
          monthStringToMonthInt(currentMonthAndYear.currentMonthSelected)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
          ));
        } else {
          return ListView.builder(
            itemCount: snapshot.data.count,
            itemBuilder: (context, index) {},
          );
        }
      },
    );
  }
}
