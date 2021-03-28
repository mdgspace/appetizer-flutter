import 'dart:math' as math;

import 'package:appetizer/colors.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:flutter/material.dart';

class MenuCardUtils {
  static CircleAvatar _getMealIcon() {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.transparent,
      child: Image.asset(
        'assets/icons/meal_icon' +
            (math.Random().nextInt(5) + 1).toString() +
            '.jpg',
        scale: 2.5,
      ),
    );
  }

  static String _dataToJoinedString(final data) {
    var dailyItemsList = <String>[];
    var dailyItems = '';
    for (var i = 0; i < data.length; i++) {
      var name = data[i].name;
      dailyItemsList.add(name);
      dailyItems = dailyItemsList.join(' , ');
    }
    return dailyItems;
  }

  static Map<MealType, String> getDailyItemsMap(DailyItems dailyItems) {
    var dailyItemsMap = <MealType, String>{
      MealType.B: _dataToJoinedString(dailyItems.breakfast),
      MealType.L: _dataToJoinedString(dailyItems.lunch),
      MealType.S: _dataToJoinedString(dailyItems.snack),
      MealType.D: _dataToJoinedString(dailyItems.dinner)
    };
    return dailyItemsMap;
  }

  static void setLeadingMealImage(List mealLeadingImageList) {
    mealLeadingImageList.add(_getMealIcon());
  }

  static Widget _menuListItem(
      Meal meal, String itemName, CircleAvatar foodIcon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 4.0),
          child: Column(
            children: <Widget>[
              foodIcon,
              SizedBox(
                height: 8.0,
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$itemName',
                ),
                Divider(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget titleAndBhawanNameComponent(Meal meal) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${meal.title}',
            style: TextStyle(
              color: appiYellow,
              fontSize: 24,
            ),
          ),
          Text(
            '${meal.hostelName}',
            style: TextStyle(
              color: appiBrown,
            ),
          ),
        ],
      ),
    );
  }

  static Widget dailyItemsComponent(Meal meal, DailyItems dailyItems) {
    final dailyItemsMap = getDailyItemsMap(dailyItems);
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Color(0xffF4F4F4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${dailyItemsMap[meal.type]}',
                style: TextStyle(color: Color.fromRGBO(0, 0, 0, .54)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static getMapMenuItems(Meal meal) {
    var map = <CircleAvatar, String>{};
    meal.items.forEach((mealItem) {
      map.putIfAbsent(
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
        () => mealItem.name,
      );
    });
    print('returning: $map');
    return map;
  }

  static List<Widget> itemWidgetList(Meal meal) {
    var list = <Widget>[];
    meal.items.forEach((mealItem) {
      list.add(
        _menuListItem(
          meal,
          mealItem.name,
          _getMealIcon(),
        ),
      );
    });
    return list;
  }

  static Widget specialMealBanner(CostType costType) {
    return costType == CostType.S
        ? Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: appiYellow,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Text(
                        'Special Meal',
                        style: TextStyle(
                          color: appiBrown,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}
