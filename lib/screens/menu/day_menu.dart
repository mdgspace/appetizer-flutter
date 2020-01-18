import 'dart:math' as math;

import 'package:appetizer/models/menu/week.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../globals.dart';
import 'menu_card.dart';

class DayMenu extends StatefulWidget {
  final String token;
  final Day currentDayMeal;
  final Map<String, String> dailyItemsMap;
  final DateTime selectedDateTime;
  final String selectedHostelCode;

  const DayMenu({
    Key key,
    this.token,
    this.currentDayMeal,
    this.dailyItemsMap,
    this.selectedDateTime,
    this.selectedHostelCode,
  }) : super(key: key);

  @override
  _DayMenuState createState() => _DayMenuState();
}

class _DayMenuState extends State<DayMenu> {
  static final double _radius = 16;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  int breakfastId;
  int lunchId;
  int snacksId;
  int dinnerId;

  List<CircleAvatar> breakfastLeadingImageList = [];
  List<CircleAvatar> lunchLeadingImageList = [];
  List<CircleAvatar> snacksLeadingImageList = [];
  List<CircleAvatar> dinnerLeadingImageList = [];

  List<String> breakfastItemsList = [];
  List<String> lunchItemsList = [];
  List<String> snacksItemsList = [];
  List<String> dinnerItemsList = [];

  Map<CircleAvatar, String> breakfastMealMap = {};
  Map<CircleAvatar, String> lunchMealMap = {};
  Map<CircleAvatar, String> snacksMealMap = {};
  Map<CircleAvatar, String> dinnerMealMap = {};

  bool isBreakfastSwitched;
  bool isLunchSwitched;
  bool isSnacksSwitched;
  bool isDinnerSwitched;

  bool isBreakfastOutdated = false;
  bool isLunchOutdated = false;
  bool isSnacksOutdated = false;
  bool isDinnerOutdated = false;

  bool isBreakfastLeaveToggleOutdated = false;
  bool isLunchLeaveToggleOutdated = false;
  bool isSnacksLeaveToggleOutdated = false;
  bool isDinnerLeaveToggleOutdated = false;

  LeaveStatus breakfastLeaveStatus;
  LeaveStatus lunchLeaveStatus;
  LeaveStatus snacksLeaveStatus;
  LeaveStatus dinnerLeaveStatus;

  DateTime breakfastStartDateTime;
  DateTime lunchStartDateTime;
  DateTime snacksStartDateTime;
  DateTime dinnerStartDateTime;

  void setLeadingMealImage(List<CircleAvatar> mealLeadingImageList) {
    var randomColor =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
            .withOpacity(0.2);
    mealLeadingImageList.add(CircleAvatar(
      radius: _radius,
      backgroundColor: randomColor,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var numberOfMeals = widget.currentDayMeal.meals.length;
    for (var i = 0; i < numberOfMeals; i++) {
      if (widget.currentDayMeal.meals[i].type == MealType.B) {
        breakfastLeaveStatus = widget.currentDayMeal.meals[i].leaveStatus;
        String breakfastDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].startTime;
        breakfastStartDateTime = dateFormat.parse(breakfastDateTimeString);
        if (!breakfastStartDateTime
            .subtract(Duration(hours: 12))
            .isAfter(DateTime.now())) {
          isBreakfastLeaveToggleOutdated = true;
        }
        if (!breakfastStartDateTime.isAfter(DateTime.now())) {
          isBreakfastOutdated = true;
        } else {
          isBreakfastOutdated = false;
        }
        breakfastId = widget.currentDayMeal.meals[i].id;
        isBreakfastSwitched =
            widget.currentDayMeal.meals[i].leaveStatus == LeaveStatus.N
                ? true
                : false;
        for (var j = 0; j < widget.currentDayMeal.meals[i].items.length; j++) {
          var breakfastMealItem = widget.currentDayMeal.meals[i].items[j].name;
          breakfastItemsList.add(breakfastMealItem);
          setLeadingMealImage(breakfastLeadingImageList);
        }
      } else if (widget.currentDayMeal.meals[i].type == MealType.L) {
        lunchLeaveStatus = widget.currentDayMeal.meals[i].leaveStatus;
        String lunchDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].startTime;
        lunchStartDateTime = dateFormat.parse(lunchDateTimeString);
        if (!lunchStartDateTime
            .subtract(Duration(hours: 12))
            .isAfter(DateTime.now())) {
          isLunchLeaveToggleOutdated = true;
        }
        if (!lunchStartDateTime.isAfter(DateTime.now())) {
          isLunchOutdated = true;
        } else {
          isLunchOutdated = false;
        }
        lunchId = widget.currentDayMeal.meals[i].id;
        isLunchSwitched =
            widget.currentDayMeal.meals[i].leaveStatus == LeaveStatus.N
                ? true
                : false;
        for (var j = 0; j < widget.currentDayMeal.meals[i].items.length; j++) {
          var lunchMealItem = widget.currentDayMeal.meals[i].items[j].name;
          lunchItemsList.add(lunchMealItem);
          setLeadingMealImage(lunchLeadingImageList);
        }
      } else if (widget.currentDayMeal.meals[i].type == MealType.S) {
        snacksLeaveStatus = widget.currentDayMeal.meals[i].leaveStatus;
        String snacksDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].startTime;
        snacksStartDateTime = dateFormat.parse(snacksDateTimeString);
        if (!snacksStartDateTime
            .subtract(Duration(hours: 12))
            .isAfter(DateTime.now())) {
          isSnacksLeaveToggleOutdated = true;
        }
        if (!snacksStartDateTime.isAfter(DateTime.now())) {
          isSnacksOutdated = true;
        } else {
          isSnacksOutdated = false;
        }
        snacksId = widget.currentDayMeal.meals[i].id;
        isSnacksSwitched =
            widget.currentDayMeal.meals[i].leaveStatus == LeaveStatus.N
                ? true
                : false;
        for (var j = 0; j < widget.currentDayMeal.meals[i].items.length; j++) {
          var snacksMealItem = widget.currentDayMeal.meals[i].items[j].name;
          snacksItemsList.add(snacksMealItem);
          setLeadingMealImage(snacksLeadingImageList);
        }
      } else if (widget.currentDayMeal.meals[i].type == MealType.D) {
        dinnerLeaveStatus = widget.currentDayMeal.meals[i].leaveStatus;
        String dinnerDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].startTime;
        dinnerStartDateTime = dateFormat.parse(dinnerDateTimeString);
        if (!dinnerStartDateTime
            .subtract(Duration(hours: 12))
            .isAfter(DateTime.now())) {
          isDinnerLeaveToggleOutdated = true;
        }
        if (!dinnerStartDateTime.isAfter(DateTime.now())) {
          isDinnerOutdated = true;
        } else {
          isDinnerOutdated = false;
        }
        dinnerId = widget.currentDayMeal.meals[i].id;
        isDinnerSwitched =
            widget.currentDayMeal.meals[i].leaveStatus == LeaveStatus.N
                ? true
                : false;
        for (var j = 0; j < widget.currentDayMeal.meals[i].items.length; j++) {
          var dinnerMealItem = widget.currentDayMeal.meals[i].items[j].name;
          dinnerItemsList.add(dinnerMealItem);
          setLeadingMealImage(dinnerLeadingImageList);
        }
      }
    }

    breakfastMealMap =
        Map.fromIterables(breakfastLeadingImageList, breakfastItemsList);
    lunchMealMap = Map.fromIterables(lunchLeadingImageList, lunchItemsList);
    dinnerMealMap = Map.fromIterables(dinnerLeadingImageList, dinnerItemsList);
    snacksMealMap = Map.fromIterables(snacksLeadingImageList, snacksItemsList);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (breakfastMealMap.isNotEmpty)
            ? MenuCard(
                'Breakfast',
                breakfastMealMap,
                widget.dailyItemsMap["breakfast"],
                breakfastId,
                widget.token,
                isBreakfastSwitched,
                isBreakfastOutdated,
                breakfastLeaveStatus,
                isCheckedOut,
                isBreakfastLeaveToggleOutdated,
                true,
                widget.selectedDateTime,
                breakfastStartDateTime,
                widget.selectedHostelCode,
              )
            : Container(),
        (lunchMealMap.isNotEmpty)
            ? MenuCard(
                'Lunch',
                lunchMealMap,
                widget.dailyItemsMap["lunch"],
                lunchId,
                widget.token,
                isLunchSwitched,
                isLunchOutdated,
                lunchLeaveStatus,
                isCheckedOut,
                isLunchLeaveToggleOutdated,
                true,
                widget.selectedDateTime,
                lunchStartDateTime,
                widget.selectedHostelCode,
              )
            : Container(),
        (snacksMealMap.isNotEmpty)
            ? MenuCard(
                'Snacks',
                snacksMealMap,
                widget.dailyItemsMap["snacks"],
                snacksId,
                widget.token,
                isSnacksSwitched,
                isSnacksOutdated,
                snacksLeaveStatus,
                isCheckedOut,
                isSnacksLeaveToggleOutdated,
                true,
                widget.selectedDateTime,
                snacksStartDateTime,
                widget.selectedHostelCode,
              )
            : Container(),
        (dinnerMealMap.isNotEmpty)
            ? MenuCard(
                'Dinner',
                dinnerMealMap,
                widget.dailyItemsMap["dinner"],
                dinnerId,
                widget.token,
                isDinnerSwitched,
                isDinnerOutdated,
                dinnerLeaveStatus,
                isCheckedOut,
                isDinnerLeaveToggleOutdated,
                true,
                widget.selectedDateTime,
                dinnerStartDateTime,
                widget.selectedHostelCode,
              )
            : Container(),
      ],
    );
  }
}
