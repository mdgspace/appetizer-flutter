import 'dart:convert';

Leave leaveFromJson(String str) => Leave.fromJson(json.decode(str));

String leaveToJson(Leave data) => json.encode(data.toJson());

class Leave {
  int id;
  double dateCreated;
  String startMealType;
  String endMealType;
  int startDatetime;
  int endDatetime;
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
        dateCreated: json['date_created'].toDouble(),
        startMealType: json['start_meal_type'],
        endMealType: json['end_meal_type'],
        startDatetime: json['start_datetime'].toDouble(),
        endDatetime: json['end_datetime'].toDouble(),
        mealCount: json['meal_count'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date_created': dateCreated,
        'start_meal_type': startMealType,
        'end_meal_type': endMealType,
        'start_datetime': startDatetime,
        'end_datetime': endDatetime,
        'meal_count': mealCount,
        'status': status,
      };
}
