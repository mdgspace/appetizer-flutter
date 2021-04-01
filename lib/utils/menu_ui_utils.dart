import 'dart:math' as math;

import 'package:appetizer/app_theme.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:flutter/material.dart';

class MenuUIUtils {
  static Widget buildtitleAndBhawanNameComponent(Meal meal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${meal.title}',
          style: AppTheme.headline1.copyWith(
            color: AppTheme.primary,
          ),
        ),
        Text(
          '${meal.hostelName}',
          style: AppTheme.bodyText1.copyWith(
            color: AppTheme.secondary,
          ),
        ),
      ],
    );
  }

  static Widget buildDailyItemsComponent(Meal meal, DailyItems dailyItems) {
    var _dailyItemsMap = <MealType, String>{
      MealType.B: dailyItems.breakfast.map((item) => item.name).join(' , '),
      MealType.L: dailyItems.lunch.map((item) => item.name).join(' , '),
      MealType.S: dailyItems.snack.map((item) => item.name).join(' , '),
      MealType.D: dailyItems.dinner.map((item) => item.name).join(' , '),
    };

    return Container(
      width: double.maxFinite,
      color: AppTheme.lightGrey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '${_dailyItemsMap[meal.type]}',
          style: AppTheme.bodyText1,
        ),
      ),
    );
  }

  static Widget buildMealItemsComponent(Meal meal) {
    return Column(
      children: meal.items
          .map(
            (item) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    'assets/icons/meal_icon' +
                        (math.Random().nextInt(5) + 1).toString() +
                        '.jpg',
                    scale: 2.5,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    child: Text('${item.name}'),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  static Widget specialMealBanner(CostType costType) {
    if (costType == CostType.S) {
      return Container(
        width: double.maxFinite,
        color: AppTheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            'Special Meal',
            style: AppTheme.bodyText1.copyWith(
              color: AppTheme.secondary,
            ),
          ),
        ),
      );
    }

    return Container();
  }
}
