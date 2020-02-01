import 'package:appetizer/change_notifiers/menu_model.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';

class WeekMenu extends StatefulWidget {
  @override
  _WeekMenuState createState() => _WeekMenuState();
}

class _WeekMenuState extends State<WeekMenu> {
  @override
  Widget build(BuildContext context) {
    final _headerTextStyle = TextStyle(color: Color(0xffFFC107), fontSize: 16);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Mess Menu",
          style: new TextStyle(
              color: Colors.white, fontSize: 25.0, fontFamily: 'Lobster_Two'),
        ),
        backgroundColor: appiBrown,
        iconTheme: new IconThemeData(color: appiYellow),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: appiBrown,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Text(
                    'Day'.toUpperCase(),
                    style: _headerTextStyle,
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: Center(
                    child: Text(
                      'Breakfast'.toUpperCase(),
                      style: _headerTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: Center(
                    child: Text(
                      'Lunch'.toUpperCase(),
                      style: _headerTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  flex: 12,
                  child: Center(
                    child: Text(
                      'Dinner'.toUpperCase(),
                      style: _headerTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Consumer<YourMenuModel>(
            builder: (BuildContext context, menu, Widget child) {
              if (menu.selectedWeekYourMeals == null) {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
                  )),
                );
              } else {
                print(menu.selectedWeekYourMeals);
                List<Widget> rows = [];
                menu.selectedWeekYourMeals.days.forEach((day) {
                  List<String> breakfast = [];
                  List<String> lunch = [];
                  List<String> dinner = [];

                  day.meals.forEach(
                    (meal) {
                      meal.items
                          .forEach((f) => print("item ${f.name} ${meal.type}"));
                      switch (meal.type) {
                        case MealType.B:
                          meal.items
                              .forEach((item) => breakfast.add(item.name));
                          print(breakfast);
                          break;
                        case MealType.L:
                          meal.items.forEach((item) => lunch.add(item.name));
                          break;
                        case MealType.S:
                          break;
                        case MealType.D:
                          meal.items.forEach((item) => dinner.add(item.name));
                          break;
                      }
                    },
                  );
                  print('B: $breakfast');
                  print('L: $lunch');
                  print('D: $dinner');
                  rows.add(_buildTableRow(
                      DateTimeUtils.getWeekDayName(day.date)
                          .substring(0, 1)
                          .toUpperCase(),
                      day.date.day,
                      breakfast,
                      lunch,
                      dinner,
                      context));
                });

                return Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: rows,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  _buildTableRow(String day, int date, List<String> breakfast,
      List<String> lunch, List<String> dinner, context) {
    final height = (MediaQuery.of(context).size.height -
            AppBar().preferredSize.height * 2.5) /
        7;
    final screenHeight = MediaQuery.of(context).size.height;
    final dateWidget = Container(
        height: height,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Color(0xfff5f5f5),
            border: Border(right: BorderSide(color: Color(0xff828282)))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xfff6f6f6)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                      child: Text(
                    day,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  )),
                ),
              ),
            ),
            Text(
              date.toString(),
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: screenHeight < 600 ? 0.0 : 12.0),
            ),
          ],
        ));

    subMapper(List<String> list) {
      return Container(
        height: height,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xff828282)),
                right: BorderSide(color: Color(0xff828282)))),
        padding: const EdgeInsets.all(0.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list
                  .map((str) => Center(
                        child: Text(
                          str,
                          style: TextStyle(fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      );
    }

    final List<Widget> _rowEntries = [
      Expanded(flex: 5, child: dateWidget),
      Expanded(flex: 12, child: subMapper(breakfast)),
      Expanded(flex: 12, child: subMapper(lunch)),
      Expanded(flex: 12, child: subMapper(dinner))
    ];

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _rowEntries);
  }
}
