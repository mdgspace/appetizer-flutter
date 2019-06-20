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
  List<dynamic> results;

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
    results: new List<dynamic>.from(json["results"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "has_next": hasNext,
    "has_previous": hasPrevious,
    "results": new List<dynamic>.from(results.map((x) => x)),
  };
}
