// To parse this JSON data, do
//
//     final confirm = confirmFromJson(jsonString);

import 'dart:convert';

Week confirmFromJson(String str) => Week.fromJson(json.decode(str));

String confirmToJson(Week data) => json.encode(data.toJson());

class Week {
  int weekId;
  int year;
  dynamic name;
  DailyItems dailyItems;
  List<Day> days;
  bool isApproved;

  Week({
    this.weekId,
    this.year,
    this.name,
    this.dailyItems,
    this.days,
    this.isApproved,
  });

  factory Week.fromJson(Map<String, dynamic> json) => new Week(
        weekId: json["week_id"],
        year: json["year"],
        name: json["name"],
        dailyItems: DailyItems.fromJson(json["daily_items"]),
        days: new List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
        isApproved: json["is_approved"],
      );

  Map<String, dynamic> toJson() => {
        "week_id": weekId,
        "year": year,
        "name": name,
        "daily_items": dailyItems.toJson(),
        "days": new List<dynamic>.from(days.map((x) => x.toJson())),
        "is_approved": isApproved,
      };
}

class DailyItems {
  int id;
  List<MealItem> breakfast;
  List<MealItem> lunch;
  List<MealItem> dinner;
  List<MealItem> snack;

  DailyItems({
    this.id,
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snack,
  });

  factory DailyItems.fromJson(Map<String, dynamic> json) => new DailyItems(
        id: json["id"],
        breakfast: new List<MealItem>.from(
            json["breakfast"].map((x) => MealItem.fromJson(x))),
        lunch: new List<MealItem>.from(
            json["lunch"].map((x) => MealItem.fromJson(x))),
        dinner: new List<MealItem>.from(
            json["dinner"].map((x) => MealItem.fromJson(x))),
        snack: new List<MealItem>.from(
            json["snack"].map((x) => MealItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "breakfast": new List<dynamic>.from(breakfast.map((x) => x.toJson())),
        "lunch": new List<dynamic>.from(lunch.map((x) => x.toJson())),
        "dinner": new List<dynamic>.from(dinner.map((x) => x.toJson())),
        "snack": new List<dynamic>.from(snack.map((x) => x.toJson())),
      };
}

List<MealItem> mealItemFromJson(String str) =>
    new List<MealItem>.from(json.decode(str).map((x) => MealItem.fromJson(x)));

String mealItemToJson(List<MealItem> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class MealItem {
  int id;
  MealItemType type;
  String name;

  MealItem({
    this.id,
    this.type,
    this.name,
  });

  factory MealItem.fromJson(Map<String, dynamic> json) => new MealItem(
        id: json["id"],
        type: breakfastTypeValues.map[json["type"]],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": breakfastTypeValues.reverse[type],
        "name": name,
      };
}

enum MealItemType { MCL, SLD, EXT, MCD, STR, SNK }

final breakfastTypeValues = new EnumValues({
  "ext": MealItemType.EXT,
  "mcd": MealItemType.MCD,
  "mcl": MealItemType.MCL,
  "sld": MealItemType.SLD,
  "snk": MealItemType.SNK,
  "str": MealItemType.STR
});

class Day {
  int id;
  int dayId;
  DateTime date;
  List<Meal> meals;

  Day({
    this.id,
    this.dayId,
    this.date,
    this.meals,
  });

  factory Day.fromJson(Map<String, dynamic> json) => new Day(
        id: json["id"],
        dayId: json["day_id"],
        date: DateTime.parse(json["date"]),
        meals: new List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day_id": dayId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "meals": new List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  int id;
  MealType type;
  List<MealItem> items;
  String startTime;
  String endTime;
  LeaveStatus leaveStatus;
  dynamic wastage;
  bool isSwitchable;
  SwitchStatus switchStatus;

  Meal({
    this.id,
    this.type,
    this.items,
    this.startTime,
    this.endTime,
    this.leaveStatus,
    this.wastage,
    this.isSwitchable,
    this.switchStatus,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => new Meal(
        id: json["id"],
        type: mealTypeValues.map[json["type"]],
        items: new List<MealItem>.from(
            json["items"].map((x) => MealItem.fromJson(x))),
        startTime: json["start_time"],
        endTime: json["end_time"],
        leaveStatus: leaveStatusValues.map[json["leave_status"]],
        wastage: json["wastage"],
        isSwitchable: json["is_switchable"],
        switchStatus: switchStatusValues.map[json["switch_status"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": mealTypeValues.reverse[type],
        "items": new List<dynamic>.from(items.map((x) => x.toJson())),
        "start_time": startTime,
        "end_time": endTime,
        "leave_status": leaveStatusValues.reverse[leaveStatus],
        "wastage": wastage,
        "is_switchable": isSwitchable,
        "switch_status": switchStatusValues.reverse[switchStatus],
      };
}

enum LeaveStatus { N, A, D, P, U }

enum SwitchStatus { N, A, D, P, U }

final leaveStatusValues = new EnumValues({
  "N": LeaveStatus.N,
  "A": LeaveStatus.A,
  "D": LeaveStatus.D,
  "P": LeaveStatus.P,
  "U": LeaveStatus.U
});

final switchStatusValues = new EnumValues({
  "N": SwitchStatus.N,
  "A": SwitchStatus.A,
  "D": SwitchStatus.D,
  "P": SwitchStatus.P,
  "U": SwitchStatus.U
});

enum MealType { B, L, S, D }

final mealTypeValues = new EnumValues(
    {"B": MealType.B, "D": MealType.D, "L": MealType.L, "S": MealType.S});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
