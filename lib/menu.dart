import 'package:appetizer/currentDateModel.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/noMeals.dart';
import 'package:appetizer/services/leave.dart';
import 'package:appetizer/services/user.dart';
import 'package:appetizer/utils/get_leave_color_from_leave_status.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/services/menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'colors.dart';
import 'screens/user_feedback/new_feedback.dart';
import 'utils/get_week_id.dart';
import 'models/menu/week.dart';
import 'dart:math' as math;

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
                )),
              );
            } else if (data == null) {
              return NoMealsScreen();
            } else {
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
                          isCheckedOut)
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
                          isCheckedOut)
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
                          isCheckedOut)
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
                          isCheckedOut)
                      : Container(),
                ],
              );
            }
          });
    }

    return getWeekMenu(widget.token, selectedDateTime.dateTime);
  }
}

class MenuCard extends StatefulWidget {
  final String token;
  final int id;
  final String title;
  final Map<CircleAvatar, String> menuItems;
  final String dailyItems;
  final bool isSwitched;
  final bool isOutdated;
  final LeaveStatus leaveStatus;
  final bool isCheckedOut;

  MenuCard(this.title, this.menuItems, this.dailyItems, this.id, this.token,
      this.isSwitched, this.isOutdated, this.leaveStatus, this.isCheckedOut);

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool isSwitched;

  List<Widget> _itemWidgetList() {
    List<Widget> list = [];
    widget.menuItems.forEach((icon, string) {
      list.add(_menuListItem(string, icon));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    isSwitched = widget.isSwitched;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(12, 4, 12, 4),
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  widget.title,
                                  style: new TextStyle(
                                      color: appiYellow, fontSize: 24),
                                ),
                                (!(getLeaveColorFromLeaveStatus(
                                                widget.leaveStatus) ==
                                            Colors.white) &&
                                        widget.isOutdated)
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 5, 30, 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color:
                                                  getLeaveColorFromLeaveStatus(
                                                      widget.leaveStatus),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 1, 12, 1),
                                            child: Text(
                                              "Skipped".toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: .5,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                        widget.isOutdated
                            ? Padding(
                                padding: const EdgeInsets.all(8),
                                child: InkWell(
                                  child: Image.asset(
                                    "assets/icons/feedback_button.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewFeedback()));
                                  },
                                ))
                            : !widget.isCheckedOut
                                ? Switch(
                                    activeColor: appiYellow,
                                    value: isSwitched,
                                    onChanged: (value) async {
                                      if (value) {
                                        cancelLeave(widget.id, widget.token)
                                            .then((leaveBool) {
                                          if (leaveBool) {
                                            setState(() {
                                              isSwitched = true;
                                              Fluttertoast.showToast(
                                                  msg: "Leave Cancelled",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIos: 1,
                                                  backgroundColor:
                                                      Color.fromRGBO(
                                                          0, 0, 0, 0.7),
                                                  textColor: Colors.white,
                                                  fontSize: 14.0);
                                            });
                                          }
                                        });
                                      } else {
                                        leave(widget.id.toString(),
                                                widget.token)
                                            .then((leaveResult) {
                                          if (leaveResult.meal == widget.id) {
                                            Fluttertoast.showToast(
                                                msg: "Meal Skipped",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIos: 1,
                                                backgroundColor: Color.fromRGBO(
                                                    0, 0, 0, 0.7),
                                                textColor: Colors.white,
                                                fontSize: 14.0);
                                            setState(() {
                                              isSwitched = false;
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Leave status cannot be changed less than 12 hours before the meal time",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIos: 1,
                                                backgroundColor: Color.fromRGBO(
                                                    0, 0, 0, 0.7),
                                                textColor: Colors.white,
                                                fontSize: 14.0);
                                          }
                                        });
                                      }
                                    })
                                : Container(),
                      ],
                    ),
                    Column(
                      children: _itemWidgetList(),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        color: Color(0xffF4F4F4),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Daily Items: ${widget.dailyItems}',
                            style:
                                TextStyle(color: Color.fromRGBO(0, 0, 0, .54)),
                          ),
                        )),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Widget _menuListItem(String itemName, CircleAvatar foodIcon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 4.0),
          child: Column(
            children: <Widget>[
              foodIcon,
              SizedBox(
                height: 8.0,
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  itemName,
                ),
                Divider(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
