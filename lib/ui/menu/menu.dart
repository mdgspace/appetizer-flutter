import 'package:appetizer/database/app_database.dart';
import 'package:appetizer/utils/connectivity_status.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/provider/current_date.dart';
import 'package:appetizer/ui/menu/day_menu.dart';
import 'package:appetizer/ui/menu/no_meals.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/services/user.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors.dart';
import '../../utils/get_week_id.dart';

class Menu extends StatefulWidget {
  final String token;
  final String selectedHostelCode;
  final String residingHostel;

  const Menu({
    Key key,
    this.token,
    this.selectedHostelCode,
    this.residingHostel,
  }) : super(key: key);

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
    SharedPreferences.getInstance().then((sharedPrefs) {
      if (sharedPrefs.getInt("mealKey") == null) {
        menuWeekForYourMeals(widget.token, getWeekNumber(DateTime.now()))
            .then((menu) {
          updateMealDb(menu);
        });
      }
    });
  }

  static const String MEAL_STORE_NAME = 'meals';

  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Week objects converted to Map
  final _mealStore = intMapStoreFactory.store(MEAL_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<void> updateMealDb(Week weekMenu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int mealKey = await _mealStore.add(await _db, weekMenu.toJson());
    prefs.setInt("mealKey", mealKey);
  }

  String breakfastDailyItems = "";
  String lunchDailyItems = "";
  String snacksDailyItems = "";
  String dinnerDailyItems = "";

  String hostelNameFromWeek = "";

  @override
  Widget build(BuildContext context) {
    final selectedDateTime = Provider.of<CurrentDateModel>(context);
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    Widget getWeekMenu(String token, DateTime dateTime) {
      return FutureBuilder(
          future: connectionStatus == ConnectivityStatus.Offline
              ? getWeekNumber(dateTime) == getWeekNumber(DateTime.now())
                  ? menuWeekFromDb()
                  : widget.selectedHostelCode ==
                          hostelCodeMap[widget.residingHostel]
                      ? menuWeekForYourMeals(token, getWeekNumber(dateTime))
                      : menuWeekMultiMessing(token, getWeekNumber(dateTime),
                          widget.selectedHostelCode)
              : widget.selectedHostelCode ==
                      hostelCodeMap[widget.residingHostel]
                  ? menuWeekForYourMeals(token, getWeekNumber(dateTime))
                  : menuWeekMultiMessing(token, getWeekNumber(dateTime),
                      widget.selectedHostelCode),
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

              hostelNameFromWeek = snapshot.data.hostelName;

              Map<String, String> dailyItemsMap = {
                "breakfast": breakfastDailyItems,
                "lunch": lunchDailyItems,
                "snacks": snacksDailyItems,
                "dinner": dinnerDailyItems
              };

              if (dateTime.weekday > data.days.length) {
                return Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Text(
                      "The menu for this day has not been uploaded yet!",
                    ),
                  ),
                );
              } else {
                //day meal fetch
                Day currentDayMeal = data.days[dateTime.weekday - 1];

                return DayMenu(
                  token: widget.token,
                  currentDayMeal: currentDayMeal,
                  dailyItemsMap: dailyItemsMap,
                  selectedDateTime: selectedDateTime.dateTime,
                  selectedHostelCode: widget.selectedHostelCode,
                  hostelName: hostelNameFromWeek,
                  residingHostel: widget.residingHostel,
                );
              }
            }
          });
    }

    return getWeekMenu(widget.token, selectedDateTime.dateTime);
  }
}
