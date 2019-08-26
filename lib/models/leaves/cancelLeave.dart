// To parse this JSON data, do
//
//     final cancelLeave = cancelLeaveFromJson(jsonString);

import 'dart:convert';

CancelLeave cancelLeaveFromJson(String str) => CancelLeave.fromJson(json.decode(str));

String cancelLeaveToJson(CancelLeave data) => json.encode(data.toJson());

class CancelLeave {
  int meal;

  CancelLeave({
    this.meal,
  });

  factory CancelLeave.fromJson(Map<String, dynamic> json) => new CancelLeave(
    meal: json["meal"],
  );

  Map<String, dynamic> toJson() => {
    "meal": meal,
  };
}
