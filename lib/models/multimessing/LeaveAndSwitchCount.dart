// To parse this JSON data, do
//
//     final leaveAndSwitchCount = leaveAndSwitchCountFromJson(jsonString);

import 'dart:convert';

LeaveAndSwitchCount leaveAndSwitchCountFromJson(String str) =>
    LeaveAndSwitchCount.fromJson(json.decode(str));

String leaveAndSwitchCountToJson(LeaveAndSwitchCount data) =>
    json.encode(data.toJson());

class LeaveAndSwitchCount {
  int leaves;
  int switches;

  LeaveAndSwitchCount({
    this.leaves,
    this.switches,
  });

  factory LeaveAndSwitchCount.fromJson(Map<String, dynamic> json) =>
      LeaveAndSwitchCount(
        leaves: json["leaves"],
        switches: json["switches"],
      );

  Map<String, dynamic> toJson() => {
        "leaves": leaves,
        "switches": switches,
      };
}
