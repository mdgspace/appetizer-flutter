// To parse this JSON data, do
//
//     final password = passwordFromJson(jsonString);

import 'dart:convert';

Password passwordFromJson(String str) => Password.fromJson(json.decode(str));

String passwordToJson(Password data) => json.encode(data.toJson());

class Password {
  String detail;

  Password({
    this.detail,
  });

  factory Password.fromJson(Map<String, dynamic> json) => new Password(
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
  };
}
