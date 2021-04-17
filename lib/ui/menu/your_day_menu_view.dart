import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/menu/components/your_meal_menu_card.dart';
import 'package:flutter/material.dart';

class YourDayMenuView extends StatefulWidget {
  final DayMenu dayMenu;
  final DailyItems dailyItems;

  const YourDayMenuView({Key key, this.dayMenu, this.dailyItems})
      : super(key: key);

  @override
  _YourDayMenuViewState createState() => _YourDayMenuViewState();
}

class _YourDayMenuViewState extends State<YourDayMenuView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        YourMealsMenuCard(
          widget.dayMenu.mealMap[MealType.B],
          widget.dailyItems,
        ),
        YourMealsMenuCard(
          widget.dayMenu.mealMap[MealType.L],
          widget.dailyItems,
        ),
        YourMealsMenuCard(
          widget.dayMenu.mealMap[MealType.S],
          widget.dailyItems,
        ),
        YourMealsMenuCard(
          widget.dayMenu.mealMap[MealType.D],
          widget.dailyItems,
        ),
      ],
    );
  }
}
