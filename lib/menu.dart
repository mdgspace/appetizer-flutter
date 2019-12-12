import 'dart:math' as math;

import 'package:appetizer/app_database.dart';
import 'package:appetizer/currentDateModel.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/menu_card.dart';
import 'package:appetizer/noMeals.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/services/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';

import 'colors.dart';
import 'models/menu/week.dart';
import 'utils/get_week_id.dart';

class Menu extends StatefulWidget {
  final String token;

  const Menu({Key key, this.token}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  static final double _radius = 16;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  void initState() {
    super.initState();
    userMeGet(widget.token).then((me) {
      setState(() {
        isCheckedOut = me.isCheckedOut;
      });
    });
  }

  static const String MEAL_STORE_NAME = 'meals';

  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Week objects converted to Map
  final _mealStore = intMapStoreFactory.store(MEAL_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<int> insert(Week weekMenu) async {
    int mealKey = await _mealStore.add(await _db, weekMenu.toJson());
    return mealKey;
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateTime = Provider.of<CurrentDateModel>(context);

    Widget getWeekMenu(String token, DateTime dateTime) {
      return FutureBuilder(
          future: menuWeek(token, getWeekNumber(dateTime)),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
                  ),
                ),
              );
            } else if (data == null) {
              return NoMealsScreen();
            } else {
              insert(data).then((mealKey) async {
                var record = await _mealStore.record(mealKey).get(await _db);
                print(record);
              });
              int breakfastId;
              int lunchId;
              int snacksId;
              int dinnerId;

              String breakfastDailyItems = "";
              String lunchDailyItems = "";
              String snacksDailyItems = "";
              String dinnerDailyItems = "";

              List<CircleAvatar> breakfastLeadingImageList = [];
              List<CircleAvatar> lunchLeadingImageList = [];
              List<CircleAvatar> snacksLeadingImageList = [];
              List<CircleAvatar> dinnerLeadingImageList = [];

              List<String> breakfastMealList = [];
              List<String> lunchMealList = [];
              List<String> snacksMealList = [];
              List<String> dinnerMealList = [];

              Map<CircleAvatar, String> breakfastMealMap = {};
              Map<CircleAvatar, String> lunchMealMap = {};
              Map<CircleAvatar, String> snacksMealMap = {};
              Map<CircleAvatar, String> dinnerMealMap = {};

              bool breakfastIsSwitched;
              bool lunchIsSwitched;
              bool snacksIsSwitched;
              bool dinnerIsSwitched;

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

              //Daily Items fetch
              List<String> breakfastDailyItemsList = [];
              for (var i = 0; i < data.dailyItems.breakfast.length; i++) {
                var name = data.dailyItems.breakfast[i].name;
                breakfastDailyItemsList.add(name);
                breakfastDailyItems = breakfastDailyItemsList.join(" , ");
              }

              List<String> lunchDailyItemsList = [];
              for (var i = 0; i < data.dailyItems.lunch.length; i++) {
                var name = data.dailyItems.lunch[i].name;
                lunchDailyItemsList.add(name);
                lunchDailyItems = lunchDailyItemsList.join(" , ");
              }

              List<String> snacksDailyItemsList = [];
              for (var i = 0; i < data.dailyItems.snack.length; i++) {
                var name = data.dailyItems.snack[i].name;
                snacksDailyItemsList.add(name);
                snacksDailyItems = snacksDailyItemsList.join(" , ");
              }

              List<String> dinnerDailyItemsList = [];
              for (var i = 0; i < data.dailyItems.dinner.length; i++) {
                var name = data.dailyItems.dinner[i].name;
                dinnerDailyItemsList.add(name);
                dinnerDailyItems = dinnerDailyItemsList.join(" , ");
              }

              //meal fetch
              Day currentDayMeal = data.days[dateTime.weekday - 1];

              var numberOfMeals = currentDayMeal.meals.length;
              for (var i = 0; i < numberOfMeals; i++) {
                if (currentDayMeal.meals[i].type == MealType.B) {
                  breakfastLeaveStatus = currentDayMeal.meals[i].leaveStatus;
                  String breakfastDateTimeString =
                      currentDayMeal.date.toString().substring(0, 10) +
                          " " +
                          currentDayMeal.meals[i].startTime;
                  DateTime breakfastStartDateTime =
                      dateFormat.parse(breakfastDateTimeString);
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
                  breakfastId = currentDayMeal.meals[i].id;
                  breakfastIsSwitched =
                      currentDayMeal.meals[i].leaveStatus == LeaveStatus.N
                          ? true
                          : false;
                  for (var j = 0;
                      j < currentDayMeal.meals[i].items.length;
                      j++) {
                    var breakfastMealItem =
                        currentDayMeal.meals[i].items[j].name;
                    breakfastMealList.add(breakfastMealItem);
                    var randomColor = Color(
                            (math.Random().nextDouble() * 0xFFFFFF).toInt() <<
                                0)
                        .withOpacity(0.2);
                    breakfastLeadingImageList.add(CircleAvatar(
                      radius: _radius,
                      backgroundColor: randomColor,
                    ));
                  }
                } else if (currentDayMeal.meals[i].type == MealType.L) {
                  lunchLeaveStatus = currentDayMeal.meals[i].leaveStatus;
                  String lunchDateTimeString =
                      currentDayMeal.date.toString().substring(0, 10) +
                          " " +
                          currentDayMeal.meals[i].startTime;
                  DateTime lunchStartDateTime =
                      dateFormat.parse(lunchDateTimeString);
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
                  lunchId = currentDayMeal.meals[i].id;
                  lunchIsSwitched =
                      currentDayMeal.meals[i].leaveStatus == LeaveStatus.N
                          ? true
                          : false;
                  for (var j = 0;
                      j < currentDayMeal.meals[i].items.length;
                      j++) {
                    var lunchMealItem = currentDayMeal.meals[i].items[j].name;
                    lunchMealList.add(lunchMealItem);
                    var randomColor = Color(
                            (math.Random().nextDouble() * 0xFFFFFF).toInt() <<
                                0)
                        .withOpacity(0.2);
                    lunchLeadingImageList.add(CircleAvatar(
                      radius: _radius,
                      backgroundColor: randomColor,
                    ));
                  }
                } else if (currentDayMeal.meals[i].type == MealType.S) {
                  snacksLeaveStatus = currentDayMeal.meals[i].leaveStatus;
                  String snacksDateTimeString =
                      currentDayMeal.date.toString().substring(0, 10) +
                          " " +
                          currentDayMeal.meals[i].startTime;
                  DateTime snacksStartDateTime =
                      dateFormat.parse(snacksDateTimeString);
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
                  snacksId = currentDayMeal.meals[i].id;
                  snacksIsSwitched =
                      currentDayMeal.meals[i].leaveStatus == LeaveStatus.N
                          ? true
                          : false;
                  for (var j = 0;
                      j < currentDayMeal.meals[i].items.length;
                      j++) {
                    var snacksMealItem = currentDayMeal.meals[i].items[j].name;
                    snacksMealList.add(snacksMealItem);
                    var randomColor = Color(
                            (math.Random().nextDouble() * 0xFFFFFF).toInt() <<
                                0)
                        .withOpacity(0.2);
                    snacksLeadingImageList.add(CircleAvatar(
                      radius: _radius,
                      backgroundColor: randomColor,
                    ));
                  }
                } else if (currentDayMeal.meals[i].type == MealType.D) {
                  dinnerLeaveStatus = currentDayMeal.meals[i].leaveStatus;
                  String dinnerDateTimeString =
                      currentDayMeal.date.toString().substring(0, 10) +
                          " " +
                          currentDayMeal.meals[i].startTime;
                  DateTime dinnerStartDateTime =
                      dateFormat.parse(dinnerDateTimeString);
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
                  dinnerId = currentDayMeal.meals[i].id;
                  dinnerIsSwitched =
                      currentDayMeal.meals[i].leaveStatus == LeaveStatus.N
                          ? true
                          : false;
                  for (var j = 0;
                      j < currentDayMeal.meals[i].items.length;
                      j++) {
                    var dinnerMealItem = currentDayMeal.meals[i].items[j].name;
                    dinnerMealList.add(dinnerMealItem);
                    var randomColor = Color(
                            (math.Random().nextDouble() * 0xFFFFFF).toInt() <<
                                0)
                        .withOpacity(0.2);
                    dinnerLeadingImageList.add(CircleAvatar(
                      radius: _radius,
                      backgroundColor: randomColor,
                    ));
                  }
                }
              }
              breakfastMealMap = Map.fromIterables(
                  breakfastLeadingImageList, breakfastMealList);
              lunchMealMap =
                  Map.fromIterables(lunchLeadingImageList, lunchMealList);
              dinnerMealMap =
                  Map.fromIterables(dinnerLeadingImageList, dinnerMealList);
              snacksMealMap =
                  Map.fromIterables(snacksLeadingImageList, snacksMealList);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  (breakfastMealMap.isNotEmpty)
                      ? MenuCard(
                          'Breakfast',
                          breakfastMealMap,
                          breakfastDailyItems,
                          breakfastId,
                          widget.token,
                          breakfastIsSwitched,
                          isBreakfastOutdated,
                          breakfastLeaveStatus,
                          isCheckedOut,
                          isBreakfastLeaveToggleOutdated)
                      : Container(),
                  (lunchMealMap.isNotEmpty)
                      ? MenuCard(
                          'Lunch',
                          lunchMealMap,
                          lunchDailyItems,
                          lunchId,
                          widget.token,
                          lunchIsSwitched,
                          isLunchOutdated,
                          lunchLeaveStatus,
                          isCheckedOut,
                          isLunchLeaveToggleOutdated)
                      : Container(),
                  (snacksMealMap.isNotEmpty)
                      ? MenuCard(
                          'Snacks',
                          snacksMealMap,
                          snacksDailyItems,
                          snacksId,
                          widget.token,
                          snacksIsSwitched,
                          isSnacksOutdated,
                          snacksLeaveStatus,
                          isCheckedOut,
                          isSnacksLeaveToggleOutdated)
                      : Container(),
                  (dinnerMealMap.isNotEmpty)
                      ? MenuCard(
                          'Dinner',
                          dinnerMealMap,
                          dinnerDailyItems,
                          dinnerId,
                          widget.token,
                          dinnerIsSwitched,
                          isDinnerOutdated,
                          dinnerLeaveStatus,
                          isCheckedOut,
                          isDinnerLeaveToggleOutdated)
                      : Container(),
                ],
              );
            }
          });
    }

    return getWeekMenu(widget.token, selectedDateTime.dateTime);
  }
}
