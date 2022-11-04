import 'dart:convert';

import 'package:appetizer/models/user/user.dart';

OAuthUser oauthUserFromJson(String str) => OAuthUser.fromJson(json.decode(str));

String oauthuserToJson(OAuthUser data) => json.encode(data.toJson());

class OAuthUser {
  String? token;
  User studentData;
  bool isNew;

  OAuthUser({
    this.token,
    required this.studentData,
    required this.isNew,
  });

  factory OAuthUser.fromJson(Map<String, dynamic> json) => OAuthUser(
        token: json['token'],
        studentData: User.fromJson(json['student_data']),
        isNew: json['is_new'],
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'student_data': studentData.toJson(),
        'is_new': isNew,
      };
}
