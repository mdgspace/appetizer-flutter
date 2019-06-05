// To parse this JSON data, do
//
//     final reset = resetFromJson(jsonString);

import 'dart:convert';

Reset resetFromJson(String str) => Reset.fromJson(json.decode(str));

String resetToJson(Reset data) => json.encode(data.toJson());

class Reset {
  String detail;

  Reset({
    this.detail,
  });

  factory Reset.fromJson(Map<String, dynamic> json) => new Reset(
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
  };
}
