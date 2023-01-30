import 'dart:math' as math;

import 'package:appetizer/app_theme.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/components/appetizer_outline_button.dart';
import 'package:appetizer/ui/components/appetizer_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MenuUIUtils {
  static Widget buildtitleAndBhawanNameComponent(Meal meal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '${meal.title}',
          style: AppTheme.headline3.copyWith(
            color: AppTheme.primary,
          ),
        ),
        Text(
          "${meal.hostelName ?? ''}${meal.hostelName != null ? ',' : ''}"
          '${DateFormat.jm().format(meal.startTime)} - ${DateFormat.jm().format(meal.endTime)}',
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
        padding: EdgeInsets.all(6.r),
        child: Text(
          '${_dailyItemsMap[meal.type]}',
          style: AppTheme.bodyText1,
        ),
      ),
    );
  }

  static Widget buildMealItemsComponent(Meal meal) {
    var cs = meal.couponStatus.status.name;
    return Column(
      children: meal.items
          .map(
            (item) => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 12.r,
                  backgroundColor: Colors.transparent,
                  child: Image.asset(
                    'assets/icons/meal_icon' +
                        (math.Random().nextInt(5) + 1).toString() +
                        '.jpg',
                    scale: 2,
                  ),
                ),
                SizedBox(width: 3.r),
                Expanded(
                  child: Container(
                    child: Text(
                      '${item.name}',
                      style: AppTheme.bodyText1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.r,
                  child: item.name.contains('Chicken')
                      ? cs == 'N'
                          ? AppetizerOutineButton(
                              title: 'Coupon',
                              onPressed: () {},
                              theme: AppTheme.red,
                              textStyle: AppTheme.bodyText3,
                              width: 10.r,
                            )
                          : AppetizerPrimaryButton(
                              title: 'Coupon',
                              onPressed: () {},
                              textStyle: AppTheme.bodyText3,
                              theme: AppTheme.red,
                              width: 10.r,
                            )
                      : SizedBox(),
                )
              ],
            ),
          )
          .toList(),
    );
  }

  static Widget buildSpecialMealBanner(CostType? costType) {
    if (costType == CostType.S) {
      return Container(
        width: double.maxFinite,
        color: AppTheme.primary,
        child: Padding(
          padding: EdgeInsets.all(4.r),
          child: Text(
            'Special Meal',
            style: AppTheme.bodyText1.copyWith(
              color: AppTheme.secondary,
            ),
          ),
        ),
      );
    }

    return SizedBox();
  }
}
