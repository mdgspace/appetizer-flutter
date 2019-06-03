// To parse this JSON data, do
//
//     final approve = approveFromJson(jsonString);

import 'dart:convert';

Approve approveFromJson(String str) => Approve.fromJson(json.decode(str));

String approveToJson(Approve data) => json.encode(data.toJson());

class Approve {
  int weekId;
  bool isApproved;

  Approve({
    this.weekId,
    this.isApproved,
  });

  factory Approve.fromJson(Map<String, dynamic> json) => new Approve(
    weekId: json["week_id"],
    isApproved: json["is_approved"],
  );

  Map<String, dynamic> toJson() => {
    "week_id": weekId,
    "is_approved": isApproved,
  };
}
