import 'dart:convert';

import 'package:appetizer/model/menu/week.dart';

MealList mealListFromJson(String str) => MealList.fromJson(json.decode(str));

String mealListToJson(MealList data) => json.encode(data.toJson());

class MealList {
  List<Meal> meals;

  MealList({
    this.meals,
  });

  factory MealList.fromJson(Map<String, dynamic> json) => new MealList(
    meals: new List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": new List<dynamic>.from(meals.map((x) => x.toJson())),
  };
}
