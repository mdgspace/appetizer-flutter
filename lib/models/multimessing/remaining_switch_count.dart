// To parse this JSON data, do
//
//     final leaveCount = leaveCountFromJson(jsonString);

import 'dart:convert';

SwitchCount switchCountFromJson(String str) =>
    SwitchCount.fromJson(json.decode(str));

String switchCountToJson(SwitchCount data) => json.encode(data.toJson());

class SwitchCount {
  int count;

  SwitchCount({
    this.count,
  });

  factory SwitchCount.fromJson(Map<String, dynamic> json) => new SwitchCount(
        count: json["switches"],
      );

  Map<String, dynamic> toJson() => {
        "switches": count,
      };
}
