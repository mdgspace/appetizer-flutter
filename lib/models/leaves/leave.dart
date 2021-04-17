import 'dart:convert';

Leave leaveFromJson(String str) => Leave.fromJson(json.decode(str));

String leaveToJson(Leave data) => json.encode(data.toJson());

class Leave {
  int id;
  DateTime dateCreated;
  String startMealType;
  String endMealType;
  DateTime startDatetime;
  DateTime endDatetime;
  int mealCount;
  String status;

  Leave({
    this.id,
    this.dateCreated,
    this.startMealType,
    this.endMealType,
    this.startDatetime,
    this.endDatetime,
    this.mealCount,
    this.status,
  });

  factory Leave.fromJson(Map<String, dynamic> json) => Leave(
        id: json['id'],
        dateCreated: DateTime.fromMillisecondsSinceEpoch(json['date_created']),
        startMealType: json['start_meal_type'],
        endMealType: json['end_meal_type'],
        startDatetime:
            DateTime.fromMillisecondsSinceEpoch(json['start_datetime']),
        endDatetime: DateTime.fromMillisecondsSinceEpoch(json['end_datetime']),
        mealCount: json['meal_count'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date_created': dateCreated.millisecondsSinceEpoch,
        'start_meal_type': startMealType,
        'end_meal_type': endMealType,
        'start_datetime': startDatetime.millisecondsSinceEpoch,
        'end_datetime': endDatetime.millisecondsSinceEpoch,
        'meal_count': mealCount,
        'status': status,
      };
}
