import 'package:appetizer/change_notifiers/menu_model.dart';
import 'package:appetizer/database/app_database.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/services/user.dart';
import 'package:appetizer/ui/menu/day_menu_new.dart';
import 'package:appetizer/ui/menu/no_meals.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/change_notifiers/current_date.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors.dart';

class Menu extends StatefulWidget {
  final String token;
  const Menu({Key key, this.token}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  static const String MEAL_STORE_NAME = 'meals';

  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Week objects converted to Map
  final _mealStore = intMapStoreFactory.store(MEAL_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;

  InheritedData inheritedData;

  var dailyItemsMap;
  String _selectedHostelcode;

  int weekId;

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
        menuWeekForYourMeals(
                widget.token, DateTimeUtils.getWeekNumber(DateTime.now()))
            .then((menu) {
          updateMealDb(menu);
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }
    final weekId = Provider.of<CurrentDateModel>(context).weekId;
    final selectedHostelCode = Provider.of<OtherMenuModel>(context).hostelCode;
    print("Menu didChange: $weekId");
    if (selectedHostelCode != this._selectedHostelcode) {
      print("Changing from $_selectedHostelcode to $selectedHostelCode");
      this._selectedHostelcode = selectedHostelCode;
    }
    if (weekId != this.weekId) {
      this.weekId = weekId;
      if (this._selectedHostelcode ==
          hostelCodeMap[inheritedData.userDetails.hostelName]) {
        Provider.of<YourMenuModel>(context, listen: false)
            .selectedWeekMenuYourMeals(weekId);
      } else {
        Provider.of<OtherMenuModel>(context, listen: false)
            .getOtherMenu(weekId);
      }
    }
  }

  Future<void> updateMealDb(Week weekMenu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int mealKey = await _mealStore.add(await _db, weekMenu.toJson());
    prefs.setInt("mealKey", mealKey);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OtherMenuModel>(
      builder: (_, otherMenuModel, __) {
        if (otherMenuModel.hostelCode ==
            hostelCodeMap[inheritedData.userDetails.hostelName]) {
          return _showYourMenu(context);
        } else {
          var selectedDateTime =
              Provider.of<CurrentDateModel>(context).dateTime;

          if (otherMenuModel.isFetching == true) {
            return _loadingIndicator(context);
          } else {
            if (otherMenuModel.isFetching == false &&
                otherMenuModel.hostelWeekMenu == null) {
              return NoMealsScreen();
            } else {
              Day currentDayMeal = otherMenuModel
                  .hostelWeekMenu.days[selectedDateTime.weekday - 1];
              final dailyItems = otherMenuModel.hostelWeekMenu.dailyItems;
              print(dailyItemsMap);
              print("OTHER DAY: $currentDayMeal");
              /*return DayMenu(
                token: widget.token,
                currentDayMeal: currentDayMeal,
                dailyItemsMap: dailyItemsMap,
                selectedDateTime: selectedDateTime,
                selectedHostelCode: otherMenuModel.hostelCode,
                hostelName: otherMenuModel.hostelCode,
              );*/
              return DayMenuNew(currentDayMeal, dailyItems, 1);
            }
          }
        }
      },
    );
  }

  Widget _menuUnavailableForSingleDay(context) => Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Center(
              child: Text(
                "The menu for this day has not been uploaded yet!",
              ),
            ),
          ),
        ],
      );

  Widget _loadingIndicator(context) => Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
          ),
        ),
      );

  Widget _showYourMenu(BuildContext context) {
    var selectedDateTime = Provider.of<CurrentDateModel>(context).dateTime;

    return Consumer<YourMenuModel>(
      builder: (_, menu, child) {
        if (menu.isFetching == true) {
          return _loadingIndicator(context);
        } else {
          if (menu.isFetching == false && menu.selectedWeekYourMeals == null) {
            return NoMealsScreen();
          } else {
            Day currentDayMeal =
                menu.selectedWeekYourMeals.days[selectedDateTime.weekday - 1];
            final dailyItems = menu.selectedWeekYourMeals.dailyItems;
            return DayMenuNew(
              currentDayMeal,
              dailyItems,
              0,
            );
          }
        }
      },
    );
  }
}
