import 'package:appetizer/utils/month_int_to_month_string.dart';
import 'package:appetizer/utils/week_day_int_to_full_day_name.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget getDayAndDateForCard(DateTime mealStartDateTime) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  String mealDateTimeString =
      mealStartDateTime.toString().substring(0, 10) + ' 00:00:00';
  DateTime mealDateTime = dateFormat.parse(mealDateTimeString);

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
    ),
    child: Column(
      children: <Widget>[
        Text(
          weekDayIntToWeekDayFullName(mealDateTime.weekday),
        ),
        Text(
          monthIntToMonthString(mealDateTime.month) +
              " " +
              mealDateTime.day.toString() +
              "," +
              mealDateTime.year.toString(),
        ),
      ],
    ),
  );
}
