import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/menu/components/other_meal_menu_card.dart';
import 'package:flutter/material.dart';

class OtherDayMenuView extends StatefulWidget {
  final DayMenu dayMenu;
  final DailyItems dailyItems;

  const OtherDayMenuView(
      {Key? key, required this.dayMenu, required this.dailyItems})
      : super(key: key);

  @override
  _OtherDayMenuViewState createState() => _OtherDayMenuViewState();
}

class _OtherDayMenuViewState extends State<OtherDayMenuView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        if (widget.dayMenu.mealMap[MealType.B] != null)
          OtherMealsMenuCard(
            widget.dayMenu.mealMap[MealType.B]!,
            widget.dailyItems,
          ),
        if (widget.dayMenu.mealMap[MealType.L] != null)
          OtherMealsMenuCard(
            widget.dayMenu.mealMap[MealType.L]!,
            widget.dailyItems,
          ),
        if (widget.dayMenu.mealMap[MealType.S] != null)
          OtherMealsMenuCard(
            widget.dayMenu.mealMap[MealType.S]!,
            widget.dailyItems,
          ),
        if (widget.dayMenu.mealMap[MealType.D] != null)
          OtherMealsMenuCard(
            widget.dayMenu.mealMap[MealType.D]!,
            widget.dailyItems,
          ),
      ],
    );
  }
}
