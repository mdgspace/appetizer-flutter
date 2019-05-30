// To parse this JSON data, do
//
//     final logout = logoutFromJson(jsonString);

import 'dart:convert';

Logout logoutFromJson(String str) => Logout.fromJson(json.decode(str));

String logoutToJson(Logout data) => json.encode(data.toJson());

class Logout {
  String detail;

  Logout({
    this.detail,
  });

  factory Logout.fromJson(Map<String, dynamic> json) => new Logout(
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
  };
}
