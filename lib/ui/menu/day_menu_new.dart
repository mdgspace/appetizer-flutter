import 'package:appetizer/models/menu/week.dart';
import 'package:appetizer/ui/components/inherited_data.dart';
import 'package:appetizer/ui/menu/meals_menu_cards.dart';
import 'package:flutter/material.dart';

class DayMenuNew extends StatefulWidget {
  final Day day;
  final DailyItems dailyItems;
  // 0->Your 1->Other
  final int menuType;
  DayMenuNew(this.day, this.dailyItems, this.menuType);

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
