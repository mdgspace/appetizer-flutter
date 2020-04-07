// To parse this JSON data, do
//
//     final oauthResponseNewUser = oauthResponseNewUserFromJson(jsonString);

import 'dart:convert';

OauthResponseNewUser oauthResponseNewUserFromJson(String str) =>
    OauthResponseNewUser.fromJson(json.decode(str));

String oauthResponseNewUserToJson(OauthResponseNewUser data) =>
    json.encode(data.toJson());

class OauthResponseNewUser {
  StudentData studentData;
  bool isNew;

  OauthResponseNewUser({
    this.studentData,
    this.isNew,
  });

  factory OauthResponseNewUser.fromJson(Map<String, dynamic> json) =>
      new OauthResponseNewUser(
        studentData: StudentData.fromJson(json["student_data"]),
        isNew: json["is_new"],
      );

  Map<String, dynamic> toJson() => {
        "student_data": studentData.toJson(),
        "is_new": isNew,
      };
}

class StudentData {
  String contactNo;
  String branch;
  String hostelName;
  String name;
  String hostelCode;
  dynamic degree;
  String email;
  int enrNo;

  StudentData({
    this.contactNo,
    this.branch,
    this.hostelName,
    this.name,
    this.hostelCode,
    this.degree,
    this.email,
    this.enrNo,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) => new StudentData(
        contactNo: json["contact_no"],
        branch: json["branch"],
        hostelName: json["hostel_name"],
        name: json["name"],
        hostelCode: json["hostel_code"],
        degree: json["degree"],
        email: json["email"],
        enrNo: json["enr_no"],
      );

  Map<String, dynamic> toJson() => {
        "contact_no": contactNo,
        "branch": branch,
        "hostel_name": hostelName,
        "name": name,
        "hostel_code": hostelCode,
        "degree": degree,
        "email": email,
        "enr_no": enrNo,
      };
}
