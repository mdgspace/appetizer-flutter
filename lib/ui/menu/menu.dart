import 'package:appetizer/change_notifiers/menu_model.dart';
import 'package:appetizer/database/app_database.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/provider/current_date.dart';
import 'package:appetizer/services/menu.dart';
import 'package:appetizer/services/user.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/menu/day_menu.dart';
import 'package:appetizer/ui/menu/no_meals.dart';
import 'package:appetizer/utils/connectivity_status.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:appetizer/utils/menu_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../colors.dart';
import '../../utils/get_week_id.dart';

class Menu extends StatefulWidget {
  final String token;

  const Menu({
    Key key,
    this.token,
  }) : super(key: key);

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

  String hostelNameFromWeek = "";
  InheritedData inheritedData;

  var dailyItemsMap;
  var selectedDateTime;
  var data;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedDateTime = Provider.of<CurrentDateModel>(context);
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }
  }

  Future<void> updateMealDb(Week weekMenu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int mealKey = await _mealStore.add(await _db, weekMenu.toJson());
    prefs.setInt("mealKey", mealKey);
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    // if selectedHostel == myHostel then
    //// if

    return Consumer<YourMenuModel>(
      builder: (_, menu, child) {
        if (menu.isFetching == 1) {
          return _loadingIndicator(context);
        } else {
          if(Provider.of<OtherMenuModel>(context).hostelCode == hostelCodeMap[inheritedData.userDetails.hostelName]) {
            menu.selectedWeekMenuYourMeals(selectedDateTime);
            data = menu.selectedWeekYourMeals;
          }else{

          }
          if (data == null) {
            return NoMealsScreen();
          } else {
            hostelNameFromWeek = data.hostelName;

            if (selectedDateTime.dateTime.weekday > data.days.length) {
              return _menuUnavailableForSingleDay(context);
            } else {
              //day meal fetch
              Day currentDayMeal =
                  data.days[selectedDateTime.dateTime.weekday - 1];
              print("AMISH : rebuild");
              dailyItemsMap = getDailyItemsMap(data);
              print(dailyItemsMap);
              return DayMenu(
                token: widget.token,
                currentDayMeal: currentDayMeal,
                dailyItemsMap: dailyItemsMap,
                selectedDateTime: selectedDateTime.dateTime,
                selectedHostelCode: Provider.of<OtherMenuModel>(context).hostelCode,
                hostelName: hostelNameFromWeek,
                residingHostel: inheritedData.userDetails.hostelName,
              );
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
}
