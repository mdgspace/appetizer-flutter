// just combine three cards into one
// pass just the daily meal to it

import 'package:appetizer_revamp_parts/models/menu/week_menu.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/YourMealMenuCard/bloc/your_meal_menu_card_bloc.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/YourMealMenuCard/your_meal_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        (dayMenu.mealMap[MealType.B] != null
            ? YourMealMenuCard(
                dailyItems: dailyItems.breakfast,
                meal: dayMenu.mealMap[MealType.B]!,
              )
            : Container(
                width: 125,
                height: 168,
                child: Text("The menu for this meal hasn't been uploaded yet!"),
              )),
        (dayMenu.mealMap[MealType.L] != null
            ? YourMealMenuCard(
                dailyItems: dailyItems.lunch,
                meal: dayMenu.mealMap[MealType.L]!)
            : Container(
                width: 125,
                height: 168,
                child: Text("The menu for this meal hasn't been uploaded yet!"),
              )),
        // SizedBox(height: 24),
        dayMenu.mealMap[MealType.S] != null
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  YourMealMenuCard(
                    dailyItems: dailyItems.snack,
                    meal: dayMenu.mealMap[MealType.S]!,
                  ),
                  SizedBox(height: 24),
                ],
              )
            : SizedBox.shrink(),
        (dayMenu.mealMap[MealType.D] != null
            ? YourMealMenuCard(
                dailyItems: dailyItems.dinner,
                meal: dayMenu.mealMap[MealType.D]!,
              )
            : Container(
                width: 125,
                height: 168,
                child: Text("The menu for this meal hasn't been uploaded yet!"),
              )),
      ],
    );
  }
}
