import 'package:appetizer/app_database.dart';
import 'package:appetizer/components/day_menu.dart';
import 'package:appetizer/currentDateModel.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/noMeals.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/services/user.dart';
import 'package:flutter/material.dart';
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

              String breakfastDailyItems = "";
              String lunchDailyItems = "";
              String snacksDailyItems = "";
              String dinnerDailyItems = "";

              Map<String, String> dailyItemsMap = {
                "breakfast": breakfastDailyItems,
                "lunch": lunchDailyItems,
                "snacks": snacksDailyItems,
                "dinner": dinnerDailyItems
              };

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

              return DayMenu(
                  token: widget.token,
                  currentDayMeal: currentDayMeal,
                  dailyItemsMap: dailyItemsMap);
            }
          });
    }

    return getWeekMenu(widget.token, selectedDateTime.dateTime);
  }
}
