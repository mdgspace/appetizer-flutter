import 'package:appetizer/globals.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/menu/meals_menu_cards.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DayMenuNew extends StatefulWidget {
  final Day day;
  final DailyItems dailyItems;
  // 0->Your 1->Other
  final int menuType;
  DayMenuNew(this.day, this.dailyItems, this.menuType) {
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
  _DayMenuNewState createState() => _DayMenuNewState();
}

class _DayMenuNewState extends State<DayMenuNew> {
  InheritedData inheritedData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (inheritedData == null) {
      inheritedData = InheritedData.of(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.menuType == 0) {
      return Column(
        children: <Widget>[
          YourMealsMenuCardNew(
              widget.day.mealMap[MealType.B], widget.dailyItems),
          YourMealsMenuCardNew(
              widget.day.mealMap[MealType.L], widget.dailyItems),
          YourMealsMenuCardNew(
              widget.day.mealMap[MealType.S], widget.dailyItems),
          YourMealsMenuCardNew(
              widget.day.mealMap[MealType.D], widget.dailyItems),
        ],
      );
    } else if (widget.menuType == 1) {
      return Column(
        children: <Widget>[
          OtherMealsMenuCardNew(
              widget.day.mealMap[MealType.B], widget.dailyItems),
          OtherMealsMenuCardNew(
              widget.day.mealMap[MealType.L], widget.dailyItems),
          OtherMealsMenuCardNew(
              widget.day.mealMap[MealType.S], widget.dailyItems),
          OtherMealsMenuCardNew(
              widget.day.mealMap[MealType.D], widget.dailyItems),
        ],
      );
    } else {
      assert(true, "INVALID MENU TYPE");
      return Text("INVALID MENU TYPE");
    }
  }
}

/*
*  String breakfastStartDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].startTime;
        breakfastStartDateTime = dateFormat.parse(breakfastStartDateTimeString);
        String breakfastEndDateTimeString =
            widget.currentDayMeal.date.toString().substring(0, 10) +
                " " +
                widget.currentDayMeal.meals[i].endTime;
        breakfastEndDateTime = dateFormat.parse(breakfastEndDateTimeString);
        if (!breakfastStartDateTime
            .subtract(outdatedTime)
            .isAfter(DateTime.now())) {
          isBreakfastLeaveToggleOutdated = true;
        }
        if (!breakfastStartDateTime.isAfter(DateTime.now())) {
          isBreakfastOutdated = true;
        } else {
          isBreakfastOutdated = false;
        }
*
* */
