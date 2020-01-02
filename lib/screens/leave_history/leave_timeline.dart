import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appetizer/screens/leave_history/multiple_leave_timeline_card.dart';
import 'package:appetizer/screens/leave_history/single_leave_timeline_card.dart';
import 'package:appetizer/utils/week_day_int_to_week_day_name.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/provider/year_and_month.dart';
import 'package:appetizer/services/leave.dart';
import 'package:appetizer/utils/month_string_to_month_int.dart';

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
          List leavesArray = [];
          for (var leaves in snapshot.data.results) {
            if (leaves.mealCount != 1) {
              leavesArray.add(MultipleLeaveTimelineCard(
                  leaves.startMealType,
                  leaves.endMealType,
                  weekDayIntToWeekDayName(
                      DateTime.fromMillisecondsSinceEpoch(leaves.startDatetime)
                          .toLocal()
                          .weekday),
                  weekDayIntToWeekDayName(
                      DateTime.fromMillisecondsSinceEpoch(leaves.endDatetime)
                          .toLocal()
                          .weekday),
                  DateTime.fromMillisecondsSinceEpoch(leaves.startDatetime)
                      .toLocal()
                      .day,
                  DateTime.fromMillisecondsSinceEpoch(leaves.endDatetime)
                      .toLocal()
                      .day,
                  leaves.mealCount));
            } else {
              leavesArray.add(SingleLeaveTimelineCard(
                leaves.startMealType,
                weekDayIntToWeekDayName(
                    DateTime.fromMillisecondsSinceEpoch(leaves.startDatetime)
                        .toLocal()
                        .weekday),
                DateTime.fromMillisecondsSinceEpoch(leaves.startDatetime)
                    .toLocal()
                    .day,
              ));
            }
          }
          return ListView.builder(
              itemCount: leavesArray.length,
              itemBuilder: (context, index) {
                return leavesArray[index];
              });
        }
      },
    );
  }
}
