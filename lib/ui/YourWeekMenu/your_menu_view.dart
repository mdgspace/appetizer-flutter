// import 'package:appetizer/constants.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/YourWeekMenu/components/DayDateBar/day_date_bar.dart';
// import 'package:appetizer/ui/YourWeekMenu/components/title_bar.dart';
import 'package:appetizer/ui/components/app_banner.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YourWeekMenu extends StatelessWidget {
  const YourWeekMenu({super.key, required this.weekMenu});
  // final DateTime monthAndYear, startDateTime, endDateTime;
  final WeekMenu weekMenu;

  @override
  Widget build(BuildContext context) {
    List<int> dates = [];
    Map<int, String> dateToMonthYear = {};
    for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
      dates.add(weekMenu.dayMenus[dayIndex].date.day);
      print("-----------");
      print(weekMenu.dayMenus[dayIndex].date);
      print("----------------");
      dateToMonthYear[weekMenu.dayMenus[dayIndex].date.day] =
          DateFormat('MMM’yy').format(weekMenu.dayMenus[dayIndex].date);
    }
    print("0000000000000");
    print(int.parse(DateFormat('dd').format(DateTime.now())));
    print("000000000000000000");
    final int currDate = !(weekMenu.dayMenus[0].date.isAfter(DateTime.now())) &&
            !(weekMenu.dayMenus[6].date.isBefore(DateTime.now()))
        ? int.parse(DateFormat('dd').format(DateTime.now()))
        : int.parse(DateFormat('dd').format(weekMenu.dayMenus[0].date));
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppBanner(
          height: 146,
          child: Column(
            children: [
              DayDateBar(
                currDate: currDate,
                dates: dates,
                dateToMonthYear: dateToMonthYear,
              ),
              // TODO: add meal cards
            ],
          ),
        ),
      ],
    );
  }
}

//  DateFormat('MMM’yy').format(weekMenu.dayMenus[0].date),