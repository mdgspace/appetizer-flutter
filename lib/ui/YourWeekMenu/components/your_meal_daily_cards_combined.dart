// just combine three cards into one
// pass just the daily meal to it

import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/YourWeekMenu/components/YourMealMenuCard/your_meal_menu_card.dart';
import 'package:flutter/material.dart';

class YourMealDailyCardsCombined extends StatelessWidget {
  const YourMealDailyCardsCombined(
      {super.key, required this.dayMenu, required this.dailyItems});
  final DayMenu dayMenu;
  final DailyItems dailyItems;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        YourMealMenuCard(
          meal: dayMenu.mealMap[MealType.B]!,
          dailyItems: dailyItems.breakfast,
        ),
        SizedBox(height: 24),
        YourMealMenuCard(
          meal: dayMenu.mealMap[MealType.L]!,
          dailyItems: dailyItems.lunch,
        ),
        SizedBox(height: 24),
        dayMenu.mealMap[MealType.S] != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  YourMealMenuCard(
                    meal: dayMenu.mealMap[MealType.S]!,
                    dailyItems: dailyItems.snack,
                  ),
                  SizedBox(height: 24),
                ],
              )
            : SizedBox.shrink(),
        YourMealMenuCard(
          meal: dayMenu.mealMap[MealType.D]!,
          dailyItems: dailyItems.dinner,
        ),
      ],
    );
  }
}
