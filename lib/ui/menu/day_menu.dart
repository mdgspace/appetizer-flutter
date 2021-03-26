import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/ui/menu/other_meal_menu_card.dart';
import 'package:appetizer/ui/menu/your_meal_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayMenu extends StatefulWidget {
  final Day day;
  final DailyItems dailyItems;
  // 0->Your 1->Other
  final int menuType;
  DayMenu(this.day, this.dailyItems, this.menuType) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String date = day.date.toString().substring(0, 10);
    for (int i = 0; i < day.meals.length; i++) {
      DateTime mealStartDateTime =
          dateFormat.parse(date + " " + day.meals[i].startTime);
      DateTime mealEndDateTime =
          dateFormat.parse(date + " " + day.meals[i].endTime);
      day.meals[i].startDateTime = mealStartDateTime;
      day.meals[i].endDateTime = mealEndDateTime;
      if (!mealStartDateTime.isAfter(DateTime.now())) {
        day.meals[i].isOutdated = true;
      } else {
        day.meals[i].isOutdated = false;
      }
      if (!mealStartDateTime.subtract(outdatedTime).isAfter(DateTime.now())) {
        day.meals[i].isLeaveToggleOutdated = true;
      } else {
        day.meals[i].isLeaveToggleOutdated = false;
      }
    }
  }

  @override
  _DayMenuState createState() => _DayMenuState();
}

class _DayMenuState extends State<DayMenu> {
  @override
  Widget build(BuildContext context) {
    if (widget.menuType == 0) {
      return GestureDetector(
        child: Column(
          children: <Widget>[
            YourMealsMenuCard(
                widget.day.mealMap[MealType.B], widget.dailyItems),
            YourMealsMenuCard(
                widget.day.mealMap[MealType.L], widget.dailyItems),
            YourMealsMenuCard(
                widget.day.mealMap[MealType.S], widget.dailyItems),
            YourMealsMenuCard(
                widget.day.mealMap[MealType.D], widget.dailyItems),
          ],
        ),
      );
    } else if (widget.menuType == 1) {
      return Column(
        children: <Widget>[
          OtherMealsMenuCard(widget.day.mealMap[MealType.B], widget.dailyItems),
          OtherMealsMenuCard(widget.day.mealMap[MealType.L], widget.dailyItems),
          OtherMealsMenuCard(widget.day.mealMap[MealType.S], widget.dailyItems),
          OtherMealsMenuCard(widget.day.mealMap[MealType.D], widget.dailyItems),
        ],
      );
    } else {
      assert(true, "INVALID MENU TYPE");
      return Text("INVALID MENU TYPE");
    }
  }
}
