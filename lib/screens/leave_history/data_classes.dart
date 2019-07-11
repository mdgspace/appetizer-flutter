import 'package:flutter/material.dart';

class TimelineData {
  final int _year;
  final String _month;
  final List<Widget> _leaveDetails;

  TimelineData(this._year, this._month, this._leaveDetails);

  int get year => _year;

  String get month => _month;

  List<Widget> get leaveDetails => _leaveDetails;
}

//class LeaveDetailsData {
//  final bool singleLeave;
//
//  final int consecutiveLeaves;
//  final String mealFrom;
//  final String mealTo;
//  final String dayFrom;
//  final String dayTo;
//  final int dateFrom;
//  final int dateTo;
//
//  final int date;
//  final String meal;
//  final String day;
//
//  LeaveDetailsData({this.singleLeave, this.consecutiveLeaves, this.mealFrom,
//    this.mealTo, this.dayFrom, this.dayTo, this.dateFrom, this.dateTo,
//    this.date, this.meal, this.day});
//
//
//}
