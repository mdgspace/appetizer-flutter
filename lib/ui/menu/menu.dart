import 'package:appetizer/change_notifiers/current_date_model.dart';
import 'package:appetizer/change_notifiers/menu_model.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/services/user.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/menu/day_menu.dart';
import 'package:appetizer/ui/menu/no_meals.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appetizer/colors.dart';

class Menu extends StatefulWidget {
  final String token;

  const Menu({Key key, this.token}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  InheritedData inheritedData;

  var dailyItemsMap;
  String _selectedHostelCode;

  int weekId;

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
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }
    final weekId = Provider.of<CurrentDateModel>(context).weekId;
    final selectedHostelCode = Provider.of<OtherMenuModel>(context).hostelCode;
    print("Menu didChange: $weekId");
    if (selectedHostelCode != this._selectedHostelCode) {
      print("Changing from $_selectedHostelCode to $selectedHostelCode");
      this._selectedHostelCode = selectedHostelCode;
    }
    if (weekId != this.weekId) {
      this.weekId = weekId;
      if (this._selectedHostelCode ==
          hostelCodeMap[inheritedData.userDetails.hostelName]) {
        Provider.of<YourMenuModel>(context, listen: false)
            .selectedWeekMenuYourMeals(weekId);
      } else {
        Provider.of<OtherMenuModel>(context, listen: false)
            .getOtherMenu(weekId);
      }
    }
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
              Day currentDayMeal;
              otherMenuModel.hostelWeekMenu.days.forEach((day) {
                if (day.date.weekday == selectedDateTime.weekday) {
                  currentDayMeal = day;
                }
              });
              if (currentDayMeal == null) {
                return _menuUnavailableForSingleDay(context);
              }
              final dailyItems = otherMenuModel.hostelWeekMenu.dailyItems;
              print(dailyItemsMap);
              print("OTHER DAY: ${currentDayMeal.toJson()}");

              return DayMenu(currentDayMeal, dailyItems, 1);
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
            Day currentDayMeal;

            menu.selectedWeekYourMeals.days.forEach((day) {
              if (day.date.weekday == selectedDateTime.weekday) {
                currentDayMeal = day;
              }
            });
            if (currentDayMeal == null) {
              return _menuUnavailableForSingleDay(context);
            }
            final dailyItems = menu.selectedWeekYourMeals.dailyItems;
            print("OTHER DAY: ${currentDayMeal.toJson()}");

            return DayMenu(
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
