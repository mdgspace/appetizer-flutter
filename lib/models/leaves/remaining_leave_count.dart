// To parse this JSON data, do
//
//     final leaveCount = leaveCountFromJson(jsonString);

import 'dart:convert';

LeaveCount leaveCountFromJson(String str) =>
    LeaveCount.fromJson(json.decode(str));

String leaveCountToJson(LeaveCount data) => json.encode(data.toJson());

class LeaveCount {
  int count;

  LeaveCount({
    this.count,
  });

  factory LeaveCount.fromJson(Map<String, dynamic> json) => new LeaveCount(
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
      };
}
