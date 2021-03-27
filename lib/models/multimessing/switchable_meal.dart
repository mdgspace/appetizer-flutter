import 'dart:convert';

List<SwitchableMeal> switchableMealsFromJson(String str) =>
    List<SwitchableMeal>.from(
        json.decode(str).map((x) => SwitchableMeal.fromJson(x)));

String switchableMealsToJson(List<SwitchableMeal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SwitchableMeal {
  int id;
  String type;
  List<Item> items;
  String startTime;
  String endTime;
  String leaveStatus;
  dynamic wastage;
  String hostelName;

  SwitchableMeal({
    this.id,
    this.type,
    this.items,
    this.startTime,
    this.endTime,
    this.leaveStatus,
    this.wastage,
    this.hostelName,
  });

  factory SwitchableMeal.fromJson(Map<String, dynamic> json) => SwitchableMeal(
        id: json['id'],
        type: json['type'],
        items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
        startTime: json['start_time'],
        endTime: json['end_time'],
        leaveStatus: json['leave_status'],
        wastage: json['wastage'],
        hostelName: json['hostel_name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'items': List<dynamic>.from(items.map((x) => x.toJson())),
        'start_time': startTime,
        'end_time': endTime,
        'leave_status': leaveStatus,
        'wastage': wastage,
        'hostel_name': hostelName,
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
        id: json['id'],
        type: json['type'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'name': name,
      };
}
