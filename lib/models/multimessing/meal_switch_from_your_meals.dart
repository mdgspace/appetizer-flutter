// To parse this JSON data, do
//
//     final switchableMealsForYourMeal = switchableMealsForYourMealFromJson(jsonString);

import 'dart:convert';

List<SwitchableMealsForYourMeal> switchableMealsForYourMealFromJson(
        String str) =>
    List<SwitchableMealsForYourMeal>.from(
        json.decode(str).map((x) => SwitchableMealsForYourMeal.fromJson(x)));

String switchableMealsForYourMealToJson(
        List<SwitchableMealsForYourMeal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SwitchableMealsForYourMeal {
  int id;
  String type;
  List<Item> items;
  String startTime;
  String endTime;
  String leaveStatus;
  dynamic wastage;
  String hostelName;

  SwitchableMealsForYourMeal({
    this.id,
    this.type,
    this.items,
    this.startTime,
    this.endTime,
    this.leaveStatus,
    this.wastage,
    this.hostelName,
  });

  factory SwitchableMealsForYourMeal.fromJson(Map<String, dynamic> json) =>
      SwitchableMealsForYourMeal(
        id: json["id"],
        type: json["type"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        startTime: json["start_time"],
        endTime: json["end_time"],
        leaveStatus: json["leave_status"],
        wastage: json["wastage"],
        hostelName: json["hostel_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "start_time": startTime,
        "end_time": endTime,
        "leave_status": leaveStatus,
        "wastage": wastage,
        "hostel_name": hostelName,
      };
}

class Item {
  int id;
  String type;
  String name;

  Item({
    this.id,
    this.type,
    this.name,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        type: json["type"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
      };
}
