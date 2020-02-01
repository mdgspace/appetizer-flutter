import 'dart:math' as math;

import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/menu/other_meals_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../globals.dart';
import 'your_meals_menu_card.dart';

class DayMenu extends StatefulWidget {
  final String token;
  final Day currentDayMeal;
  final Map<String, String> dailyItemsMap;
  final DateTime selectedDateTime;
  final String selectedHostelCode;
  final String hostelName;

  const DayMenu({
    Key key,
    this.token,
    this.currentDayMeal,
    this.dailyItemsMap,
    this.selectedDateTime,
    this.selectedHostelCode,
    this.hostelName,
  }) : super(key: key);

  @override
  _DayMenuState createState() => _DayMenuState();
}

class _DayMenuState extends State<DayMenu> {
  InheritedData inheritedData;

  static final double _radius = 16;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }
  }

  int breakfastId;
  int lunchId;
  int snacksId;
  int dinnerId;

  List<CircleAvatar> breakfastLeadingImageList;
  List<CircleAvatar> lunchLeadingImageList;
  List<CircleAvatar> snacksLeadingImageList;
  List<CircleAvatar> dinnerLeadingImageList;

  List<String> breakfastItemsList;
  List<String> lunchItemsList;
  List<String> snacksItemsList;
  List<String> dinnerItemsList;

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

  DateTime breakfastEndDateTime;
  DateTime lunchEndDateTime;
  DateTime snacksEndDateTime;
  DateTime dinnerEndDateTime;

  bool isBreakfastSwitchable;
  bool isLunchSwitchable;
  bool isSnacksSwitchable;
  bool isDinnerSwitchable;

  SwitchStatus breakfastSwitchStatus;
  SwitchStatus lunchSwitchStatus;
  SwitchStatus snacksSwitchStatus;
  SwitchStatus dinnerSwitchStatus;

  String breakfastHostelName;
  String lunchHostelName;
  String snacksHostelName;
  String dinnerHostelName;

  String breakfastSecretCode;
  String lunchSecretCode;
  String snacksSecretCode;
  String dinnerSecretCode;

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
        String breakfastStartDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].startTime;
        breakfastStartDateTime = dateFormat.parse(breakfastStartDateTimeString);
        String breakfastEndDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].endTime;
        breakfastEndDateTime = dateFormat.parse(breakfastEndDateTimeString);
        if (!breakfastStartDateTime
            .subtract(outdatedTime)
            .isAfter(DateTime.now())) {
          isBreakfastLeaveToggleOutdated = true;
        }
        if (!breakfastStartDateTime.isAfter(DateTime.now())) {
          isBreakfastOutdated = true;
        } else {
          isBreakfastOutdated = false;
        }
        isBreakfastSwitchable = widget.currentDayMeal.meals[i].isSwitchable;
        breakfastSwitchStatus = widget.currentDayMeal.meals[i].switchStatus;
        if (inheritedData.userDetails.hostelName == widget.hostelName) {
          breakfastHostelName = widget.currentDayMeal.meals[i].hostelName;
          breakfastSecretCode = widget.currentDayMeal.meals[i].secretCode;
        }
        breakfastId = widget.currentDayMeal.meals[i].id;
        isBreakfastSwitched =
            widget.currentDayMeal.meals[i].leaveStatus.status ==
                    LeaveStatusEnum.N
                ? true
                : false;
        breakfastItemsList = [];
        breakfastLeadingImageList = [];
        for (var j = 0; j < widget.currentDayMeal.meals[i].items.length; j++) {
          var breakfastMealItem = widget.currentDayMeal.meals[i].items[j].name;
          breakfastItemsList.add(breakfastMealItem);
          setLeadingMealImage(breakfastLeadingImageList);
        }
      } else if (widget.currentDayMeal.meals[i].type == MealType.L) {
        lunchLeaveStatus = widget.currentDayMeal.meals[i].leaveStatus;
        String lunchStartDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].startTime;
        lunchStartDateTime = dateFormat.parse(lunchStartDateTimeString);
        String lunchEndDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].endTime;
        lunchEndDateTime = dateFormat.parse(lunchEndDateTimeString);
        if (!lunchStartDateTime
            .subtract(outdatedTime)
            .isAfter(DateTime.now())) {
          isLunchLeaveToggleOutdated = true;
        }
        if (!lunchStartDateTime.isAfter(DateTime.now())) {
          isLunchOutdated = true;
        } else {
          isLunchOutdated = false;
        }
        isLunchSwitchable = widget.currentDayMeal.meals[i].isSwitchable;
        lunchSwitchStatus = widget.currentDayMeal.meals[i].switchStatus;
        if (inheritedData.userDetails.hostelName == widget.hostelName) {
          lunchHostelName = widget.currentDayMeal.meals[i].hostelName;
          lunchSecretCode = widget.currentDayMeal.meals[i].secretCode;
        }
        lunchId = widget.currentDayMeal.meals[i].id;
        isLunchSwitched = widget.currentDayMeal.meals[i].leaveStatus.status ==
                LeaveStatusEnum.N
            ? true
            : false;
        lunchItemsList = [];
        lunchLeadingImageList = [];

        for (var j = 0; j < widget.currentDayMeal.meals[i].items.length; j++) {
          var lunchMealItem = widget.currentDayMeal.meals[i].items[j].name;
          lunchItemsList.add(lunchMealItem);
          setLeadingMealImage(lunchLeadingImageList);
        }
      } else if (widget.currentDayMeal.meals[i].type == MealType.S) {
        snacksLeaveStatus = widget.currentDayMeal.meals[i].leaveStatus;
        String snacksStartDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].startTime;
        snacksStartDateTime = dateFormat.parse(snacksStartDateTimeString);
        String snacksEndDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].endTime;
        snacksEndDateTime = dateFormat.parse(snacksEndDateTimeString);
        if (!snacksStartDateTime
            .subtract(outdatedTime)
            .isAfter(DateTime.now())) {
          isSnacksLeaveToggleOutdated = true;
        }
        if (!snacksStartDateTime.isAfter(DateTime.now())) {
          isSnacksOutdated = true;
        } else {
          isSnacksOutdated = false;
        }
        isSnacksSwitchable = widget.currentDayMeal.meals[i].isSwitchable;
        snacksSwitchStatus = widget.currentDayMeal.meals[i].switchStatus;
        if (inheritedData.userDetails.hostelName == widget.hostelName) {
          snacksHostelName = widget.currentDayMeal.meals[i].hostelName;
          snacksSecretCode = widget.currentDayMeal.meals[i].secretCode;
        }
        snacksId = widget.currentDayMeal.meals[i].id;
        isSnacksSwitched = widget.currentDayMeal.meals[i].leaveStatus.status ==
                LeaveStatusEnum.N
            ? true
            : false;
        snacksItemsList = [];
        snacksLeadingImageList = [];

        for (var j = 0; j < widget.currentDayMeal.meals[i].items.length; j++) {
          var snacksMealItem = widget.currentDayMeal.meals[i].items[j].name;
          snacksItemsList.add(snacksMealItem);
          setLeadingMealImage(snacksLeadingImageList);
        }
      } else if (widget.currentDayMeal.meals[i].type == MealType.D) {
        dinnerLeaveStatus = widget.currentDayMeal.meals[i].leaveStatus;
        String dinnerStartDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].startTime;
        dinnerStartDateTime = dateFormat.parse(dinnerStartDateTimeString);
        String dinnerEndDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].endTime;
        dinnerEndDateTime = dateFormat.parse(dinnerEndDateTimeString);
        if (!dinnerStartDateTime
            .subtract(outdatedTime)
            .isAfter(DateTime.now())) {
          isDinnerLeaveToggleOutdated = true;
        }
        if (!dinnerStartDateTime.isAfter(DateTime.now())) {
          isDinnerOutdated = true;
        } else {
          isDinnerOutdated = false;
        }
        isDinnerSwitchable = widget.currentDayMeal.meals[i].isSwitchable;
        dinnerSwitchStatus = widget.currentDayMeal.meals[i].switchStatus;
        if (inheritedData.userDetails.hostelName == widget.hostelName) {
          dinnerHostelName = widget.currentDayMeal.meals[i].hostelName;
          dinnerSecretCode = widget.currentDayMeal.meals[i].secretCode;
        }
        dinnerId = widget.currentDayMeal.meals[i].id;
        isDinnerSwitched = widget.currentDayMeal.meals[i].leaveStatus.status ==
                LeaveStatusEnum.N
            ? true
            : false;
        dinnerItemsList = [];
        dinnerLeadingImageList = [];
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
            ? inheritedData.userDetails.hostelName == widget.hostelName
                ? YourMealsMenuCard(
                    title: 'Breakfast',
                    menuItems: breakfastMealMap,
                    dailyItems: widget.dailyItemsMap["breakfast"],
                    id: breakfastId,
                    token: widget.token,
                    isSwitched: isBreakfastSwitched,
                    isOutdated: isBreakfastOutdated,
                    leaveStatus: breakfastLeaveStatus,
                    isCheckedOut: isCheckedOut,
                    isToggleOutdated: isBreakfastLeaveToggleOutdated,
                    isSwitchable: isBreakfastSwitchable,
                    selectedDateTime: widget.selectedDateTime,
                    mealStartDateTime: breakfastStartDateTime,
                    mealEndDateTime: breakfastEndDateTime,
                    selectedHostelCode: widget.selectedHostelCode,
                    switchStatus: breakfastSwitchStatus,
                    hostelName: breakfastHostelName,
                    secretCode: breakfastSecretCode,
                  )
                : OtherMealsMenuCard(
                    title: 'Breakfast',
                    menuItems: breakfastMealMap,
                    dailyItems: widget.dailyItemsMap["breakfast"],
                    id: breakfastId,
                    token: widget.token,
                    isSwitched: isBreakfastSwitched,
                    isOutdated: isBreakfastOutdated,
                    isCheckedOut: isCheckedOut,
                    isToggleOutdated: isBreakfastLeaveToggleOutdated,
                    isSwitchable: isBreakfastSwitchable,
                    selectedDateTime: widget.selectedDateTime,
                    mealStartDateTime: breakfastStartDateTime,
                    selectedHostelCode: widget.selectedHostelCode,
                    switchStatus: breakfastSwitchStatus,
                    hostelName: widget.hostelName,
                  )
            : Container(),
        (lunchMealMap.isNotEmpty)
            ? inheritedData.userDetails.hostelName == widget.hostelName
                ? YourMealsMenuCard(
                    title: 'Lunch',
                    menuItems: lunchMealMap,
                    dailyItems: widget.dailyItemsMap["lunch"],
                    id: lunchId,
                    token: widget.token,
                    isSwitched: isLunchSwitched,
                    isOutdated: isLunchOutdated,
                    leaveStatus: lunchLeaveStatus,
                    isCheckedOut: isCheckedOut,
                    isToggleOutdated: isLunchLeaveToggleOutdated,
                    isSwitchable: isLunchSwitchable,
                    selectedDateTime: widget.selectedDateTime,
                    mealStartDateTime: lunchStartDateTime,
                    mealEndDateTime: lunchEndDateTime,
                    selectedHostelCode: widget.selectedHostelCode,
                    switchStatus: lunchSwitchStatus,
                    hostelName: lunchHostelName,
                    secretCode: lunchSecretCode,
                  )
                : OtherMealsMenuCard(
                    title: 'Lunch',
                    menuItems: lunchMealMap,
                    dailyItems: widget.dailyItemsMap["lunch"],
                    id: lunchId,
                    token: widget.token,
                    isSwitched: isLunchSwitched,
                    isOutdated: isLunchOutdated,
                    isCheckedOut: isCheckedOut,
                    isToggleOutdated: isLunchLeaveToggleOutdated,
                    isSwitchable: isLunchSwitchable,
                    selectedDateTime: widget.selectedDateTime,
                    mealStartDateTime: lunchStartDateTime,
                    selectedHostelCode: widget.selectedHostelCode,
                    switchStatus: lunchSwitchStatus,
                    hostelName: widget.hostelName,
                  )
            : Container(),
        (snacksMealMap.isNotEmpty)
            ? inheritedData.userDetails.hostelName == widget.hostelName
                ? YourMealsMenuCard(
                    title: 'Snacks',
                    menuItems: snacksMealMap,
                    dailyItems: widget.dailyItemsMap["snacks"],
                    id: snacksId,
                    token: widget.token,
                    isSwitched: isSnacksSwitched,
                    isOutdated: isSnacksOutdated,
                    leaveStatus: snacksLeaveStatus,
                    isCheckedOut: isCheckedOut,
                    isToggleOutdated: isSnacksLeaveToggleOutdated,
                    isSwitchable: isSnacksSwitchable,
                    selectedDateTime: widget.selectedDateTime,
                    mealStartDateTime: snacksStartDateTime,
                    mealEndDateTime: snacksEndDateTime,
                    selectedHostelCode: widget.selectedHostelCode,
                    switchStatus: snacksSwitchStatus,
                    hostelName: snacksHostelName,
                    secretCode: snacksSecretCode,
                  )
                : OtherMealsMenuCard(
                    title: 'Snacks',
                    menuItems: snacksMealMap,
                    dailyItems: widget.dailyItemsMap["snacks"],
                    id: snacksId,
                    token: widget.token,
                    isSwitched: isSnacksSwitched,
                    isOutdated: isSnacksOutdated,
                    isCheckedOut: isCheckedOut,
                    isToggleOutdated: isSnacksLeaveToggleOutdated,
                    isSwitchable: isSnacksSwitchable,
                    selectedDateTime: widget.selectedDateTime,
                    mealStartDateTime: snacksStartDateTime,
                    selectedHostelCode: widget.selectedHostelCode,
                    switchStatus: snacksSwitchStatus,
                    hostelName: widget.hostelName,
                  )
            : Container(),
        (dinnerMealMap.isNotEmpty)
            ? inheritedData.userDetails.hostelName == widget.hostelName
                ? YourMealsMenuCard(
                    title: 'Dinner',
                    menuItems: dinnerMealMap,
                    dailyItems: widget.dailyItemsMap["dinner"],
                    id: dinnerId,
                    token: widget.token,
                    isSwitched: isDinnerSwitched,
                    isOutdated: isDinnerOutdated,
                    leaveStatus: dinnerLeaveStatus,
                    isCheckedOut: isCheckedOut,
                    isToggleOutdated: isDinnerLeaveToggleOutdated,
                    isSwitchable: isDinnerSwitchable,
                    selectedDateTime: widget.selectedDateTime,
                    mealStartDateTime: dinnerStartDateTime,
                    mealEndDateTime: dinnerEndDateTime,
                    selectedHostelCode: widget.selectedHostelCode,
                    switchStatus: dinnerSwitchStatus,
                    hostelName: dinnerHostelName,
                    secretCode: dinnerSecretCode,
                  )
                : OtherMealsMenuCard(
                    title: 'Dinner',
                    menuItems: dinnerMealMap,
                    dailyItems: widget.dailyItemsMap["dinner"],
                    id: dinnerId,
                    token: widget.token,
                    isSwitched: isDinnerSwitched,
                    isOutdated: isDinnerOutdated,
                    isCheckedOut: isCheckedOut,
                    isToggleOutdated: isDinnerLeaveToggleOutdated,
                    isSwitchable: isDinnerSwitchable,
                    selectedDateTime: widget.selectedDateTime,
                    mealStartDateTime: dinnerStartDateTime,
                    selectedHostelCode: widget.selectedHostelCode,
                    switchStatus: dinnerSwitchStatus,
                    hostelName: widget.hostelName,
                  )
            : Container(),
      ],
    );
  }
}
