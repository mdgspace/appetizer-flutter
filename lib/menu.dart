import 'package:appetizer/currentDateModel.dart';
import 'package:appetizer/noMeals.dart';
import 'package:appetizer/services/leave.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/services/menu.dart';
import 'package:provider/provider.dart';
import 'colors.dart';
import 'utils/get_week_id.dart';
import 'models/menu/week.dart';
import 'dart:math' as math;
import 'package:appetizer/globals.dart';

class Menu extends StatefulWidget {
  final String token;

  const Menu({Key key, this.token}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  static final double _radius = 16;

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
                          breakfastIsSwitched)
                      : Container(),
                  (lunchMealMap.isNotEmpty)
                      ? MenuCard('Lunch', lunchMealMap, lunchDailyItems,
                          lunchId, widget.token, lunchIsSwitched)
                      : Container(),
                  (snacksMealMap.isNotEmpty)
                      ? MenuCard('Snacks', snacksMealMap, snacksDailyItems,
                          snacksId, widget.token, snacksIsSwitched)
                      : Container(),
                  (dinnerMealMap.isNotEmpty)
                      ? MenuCard('Dinner', dinnerMealMap, dinnerDailyItems,
                          dinnerId, widget.token, dinnerIsSwitched)
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

  MenuCard(this.title, this.menuItems, this.dailyItems, this.id, this.token,
      this.isSwitched);

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool isSwitched;
  bool outdated = false;

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
                            child: Text(
                              widget.title,
                              style: new TextStyle(
                                  color: appiYellow, fontSize: 24),
                            ),
                          ),
                        ),
                        outdated
                            ? Icon(Icons.comment)
                            : Switch(
                                activeColor: appiYellow,
                                value: isSwitched,
                                onChanged: (value) async {
                                  if (value) {
                                    cancelLeave(widget.id, widget.token)
                                        .then((leave) {
                                      setState(() {
                                        isSwitched = true;
                                        menuScaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text("Leave cancelled")));
                                      });
                                    });
                                  } else {
                                    leave(widget.id.toString(), widget.token)
                                        .then((leaveResult) {
                                      if (leaveResult.meal == widget.id) {
                                        menuScaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Your leave has been created!!")));
                                        setState(() {
                                          isSwitched = false;
                                        });
                                      } else {
                                        menuScaffoldKey.currentState
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Time for creating leave has passed")));
                                      }
                                    });
                                  }
                                }),
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
