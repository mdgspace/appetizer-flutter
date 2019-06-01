// To parse this JSON data, do
//
//     final image = imageFromJson(jsonString);

import 'dart:convert';

Image imageFromJson(String str) => Image.fromJson(json.decode(str));

String imageToJson(Image data) => json.encode(data.toJson());

class Image {
  String detail;

  Image({
    this.detail,
  });

  factory Image.fromJson(Map<String, dynamic> json) => new Image(
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "detail": detail,
  };
}
