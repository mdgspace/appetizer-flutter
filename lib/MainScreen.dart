import 'package:appetizer/currentDateModel.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/services/menu.dart';
import 'package:provider/provider.dart';
import 'colors.dart';
import 'helper_methods/getDayIdforDjango.dart';
import 'helper_methods/getWeekId.dart';
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

  Widget getCurrentWeekMenu(String token, DateTime dateTime) {
    String breakfastDailyItems = "";
    String lunchDailyItems = "";
    String snacksDailyItems = "";
    String dinnerDailyItems = "";

    var dayMenuFutureBuilder = FutureBuilder(
        future: menuDay(token, getWeekNumber(dateTime), getDayId(dateTime)),
        builder: (context, snapshot) {
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

          var data = snapshot.data;
          if (snapshot.data == null) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
              )),
            );
          } else {
            var numberOfMeals = data.meals.length;
            for (var i = 0; i < numberOfMeals; i++) {
              if (data.meals[i].type == MealType.B) {
                for (var j = 0; j < data.meals[i].items.length; j++) {
                  var breakfastMealItem = data.meals[i].items[j].name;
                  breakfastMealList.add(breakfastMealItem);
                  var randomColor = Color(
                          (math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                      .withOpacity(0.2);
                  breakfastLeadingImageList.add(CircleAvatar(
                    radius: _radius,
                    backgroundColor: randomColor,
                  ));
                }
              } else if (data.meals[i].type == MealType.L) {
                for (var j = 0; j < data.meals[i].items.length; j++) {
                  var lunchMealItem = data.meals[i].items[j].name;
                  lunchMealList.add(lunchMealItem);
                  var randomColor = Color(
                          (math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                      .withOpacity(0.2);
                  lunchLeadingImageList.add(CircleAvatar(
                    radius: _radius,
                    backgroundColor: randomColor,
                  ));
                }
              } else if (data.meals[i].type == MealType.S) {
                for (var j = 0; j < data.meals[i].items.length; j++) {
                  var snacksMealItem = data.meals[i].items[j].name;
                  snacksMealList.add(snacksMealItem);
                  var randomColor = Color(
                          (math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                      .withOpacity(0.2);
                  snacksLeadingImageList.add(CircleAvatar(
                    radius: _radius,
                    backgroundColor: randomColor,
                  ));
                }
              } else if (data.meals[i].type == MealType.D) {
                for (var j = 0; j < data.meals[i].items.length; j++) {
                  var dinnerMealItem = data.meals[i].items[j].name;
                  dinnerMealList.add(dinnerMealItem);
                  var randomColor = Color(
                          (math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                      .withOpacity(0.2);
                  dinnerLeadingImageList.add(CircleAvatar(
                    radius: _radius,
                    backgroundColor: randomColor,
                  ));
                }
              }
            }
            breakfastMealMap =
                Map.fromIterables(breakfastLeadingImageList, breakfastMealList);
            lunchMealMap =
                Map.fromIterables(lunchLeadingImageList, lunchMealList);
            dinnerMealMap =
                Map.fromIterables(dinnerLeadingImageList, dinnerMealList);
            snacksMealMap =
                Map.fromIterables(snacksLeadingImageList, snacksMealList);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              (breakfastMealMap.isNotEmpty)
                  ? MenuCard('Breakfast', breakfastMealMap, breakfastDailyItems)
                  : Container(),
              (lunchMealMap.isNotEmpty)
                  ? MenuCard('Lunch', lunchMealMap, lunchDailyItems)
                  : Container(),
              (snacksMealMap.isNotEmpty)
                  ? MenuCard('Snacks', snacksMealMap, snacksDailyItems)
                  : Container(),
              (dinnerMealMap.isNotEmpty)
                  ? MenuCard('Dinner', dinnerMealMap, dinnerDailyItems)
                  : Container(),
            ],
          );
        });

    return FutureBuilder(
        future: menuWeek(token),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
              )),
            );
          } else {
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

            return dayMenuFutureBuilder;
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateTime = Provider.of<CurrentDateModel>(context);
    return getCurrentWeekMenu(widget.token, selectedDateTime.dateTime);
  }
}

class MenuCard extends StatefulWidget {
  final String title;
  final Map<CircleAvatar, String> menuItems;
  final String dailyItems;

  MenuCard(this.title, this.menuItems, this.dailyItems);

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool isSwitched = true;
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
    return Card(
        margin: EdgeInsets.fromLTRB(12, 4, 12, 4),
        elevation: 1,
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
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              color: Colors.yellow[700], fontSize: 24),
                        ),
                      ),
                      outdated
                          ? Icon(Icons.comment)
                          : Switch(
                              activeColor: appiYellow,
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
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
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, .54),
                              fontFamily: "Roboto"),
                        ),
                      )),
                ),
              ],
            )
          ],
        ));
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
                  style: TextStyle(fontFamily: "Roboto"),
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
