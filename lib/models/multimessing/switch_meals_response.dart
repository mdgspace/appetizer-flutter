// To parse this JSON data, do
//
//     final switchResponse = switchResponseFromJson(jsonString);

import 'dart:convert';

SwitchResponse switchResponseFromJson(String str) =>
    SwitchResponse.fromJson(json.decode(str));

String switchResponseToJson(SwitchResponse data) => json.encode(data.toJson());

class SwitchResponse {
  String secretCode;

  SwitchResponse({
    this.secretCode,
  });

  factory SwitchResponse.fromJson(Map<String, dynamic> json) => SwitchResponse(
        secretCode: json["secret_code"],
      );

  Map<String, dynamic> toJson() => {
        "secret_code": secretCode,
      };
}
