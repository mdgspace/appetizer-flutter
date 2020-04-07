// To parse this JSON data, do
//
//     final leaveList = leaveListFromJson(jsonString);

import 'dart:convert';

LeaveList leaveListFromJson(String str) => LeaveList.fromJson(json.decode(str));

String leaveListToJson(LeaveList data) => json.encode(data.toJson());

class LeaveList {
  int count;
  bool hasNext;
  bool hasPrevious;
  List<Result> results;

  LeaveList({
    this.count,
    this.hasNext,
    this.hasPrevious,
    this.results,
  });

  factory LeaveList.fromJson(Map<String, dynamic> json) => new LeaveList(
        count: json["count"],
        hasNext: json["has_next"],
        hasPrevious: json["has_previous"],
        results: new List<Result>.from(
            json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "has_next": hasNext,
        "has_previous": hasPrevious,
        "results": new List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  int dateCreated;
  String startMealType;
  int startDatetime;
  String status;
  int mealCount;
  String endMealType;
  int endDatetime;

  Result({
    this.id,
    this.dateCreated,
    this.startMealType,
    this.startDatetime,
    this.status,
    this.mealCount,
    this.endMealType,
    this.endDatetime,
  });

  factory Result.fromJson(Map<String, dynamic> json) => new Result(
        id: json["id"],
        dateCreated: json["date_created"],
        startMealType: json["start_meal_type"],
        startDatetime: json["start_datetime"],
        status: json["status"],
        mealCount: json["meal_count"],
        endMealType: json["end_meal_type"],
        endDatetime: json["end_datetime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated,
        "start_meal_type": startMealType,
        "start_datetime": startDatetime,
        "status": status,
        "meal_count": mealCount,
        "end_meal_type": endMealType,
        "end_datetime": endDatetime,
      };
}
