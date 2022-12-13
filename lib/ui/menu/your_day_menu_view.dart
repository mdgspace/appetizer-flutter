import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/menu/components/your_meal_menu_card.dart';
import 'package:flutter/material.dart';

class YourDayMenuView extends StatefulWidget {
  final DayMenu dayMenu;
  final DailyItems dailyItems;

  const YourDayMenuView(
      {Key? key, required this.dayMenu, required this.dailyItems})
      : super(key: key);

  @override
  _YourDayMenuViewState createState() => _YourDayMenuViewState();
}

class _YourDayMenuViewState extends State<YourDayMenuView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        if (widget.dayMenu.mealMap[MealType.B] != null)
          YourMealsMenuCard(
            meal: widget.dayMenu.mealMap[MealType.B]!,
            dailyItems: widget.dailyItems,
          ),
        if (widget.dayMenu.mealMap[MealType.L] != null)
          YourMealsMenuCard(
            meal: widget.dayMenu.mealMap[MealType.L]!,
            dailyItems: widget.dailyItems,
          ),
        if (widget.dayMenu.mealMap[MealType.S] != null)
          YourMealsMenuCard(
            meal: widget.dayMenu.mealMap[MealType.S]!,
            dailyItems: widget.dailyItems,
          ),
        if (widget.dayMenu.mealMap[MealType.D] != null)
          YourMealsMenuCard(
            meal: widget.dayMenu.mealMap[MealType.D]!,
            dailyItems: widget.dailyItems,
          ),
      ],
    );
  }
}
