// To parse this JSON data, do
//
//     final cancelLeave = cancelLeaveFromJson(jsonString);

import 'dart:convert';

CancelLeave cancelLeaveFromJson(String str) =>
    CancelLeave.fromJson(json.decode(str));

String cancelLeaveToJson(CancelLeave data) => json.encode(data.toJson());

class CancelLeave {
  String detail;

  CancelLeave({
    this.detail,
  });

  factory CancelLeave.fromJson(Map<String, dynamic> json) => new CancelLeave(
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "detail": detail,
      };
}
