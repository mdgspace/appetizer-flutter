// To parse this JSON data, do
//
//     final versionCheck = versionCheckFromJson(jsonString);

import 'dart:convert';

VersionCheck versionCheckFromJson(String str) =>
    VersionCheck.fromJson(json.decode(str));

String versionCheckToJson(VersionCheck data) => json.encode(data.toJson());

class VersionCheck {
  String number;
  String platform;
  dynamic expiryDate;
  bool isExpired;
  bool isLatest;
  int dateCreated;

  VersionCheck({
    this.number,
    this.platform,
    this.expiryDate,
    this.isExpired,
    this.isLatest,
    this.dateCreated,
  });

  factory VersionCheck.fromJson(Map<String, dynamic> json) => VersionCheck(
        number: json["number"],
        platform: json["platform"],
        expiryDate: json["expiry_date"],
        isExpired: json["is_expired"],
        isLatest: json["is_latest"],
        dateCreated: json["date_created"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "platform": platform,
        "expiry_date": expiryDate,
        "is_expired": isExpired,
        "is_latest": isLatest,
        "date_created": dateCreated,
      };
}
