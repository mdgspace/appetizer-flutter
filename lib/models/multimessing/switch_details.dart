// To parse this JSON data, do
//
//     final switchDetails = switchDetailsFromJson(jsonString);

import 'dart:convert';

SwitchDetails switchDetailsFromJson(String str) =>
    SwitchDetails.fromJson(json.decode(str));

String switchDetailsToJson(SwitchDetails data) => json.encode(data.toJson());

class SwitchDetails {
  int id;
  int toMeal;
  String secretCode;
  String status;

  SwitchDetails({
    this.id,
    this.toMeal,
    this.secretCode,
    this.status,
  });

  factory SwitchDetails.fromJson(Map<String, dynamic> json) => SwitchDetails(
        id: json["id"],
        toMeal: json["to_meal"],
        secretCode: json["secret_code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "to_meal": toMeal,
        "secret_code": secretCode,
        "status": status,
      };
}
