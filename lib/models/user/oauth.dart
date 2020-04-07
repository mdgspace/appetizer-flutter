// To parse this JSON data, do
//
//     final oauthRedirectResponse = oauthRedirectResponseFromJson(jsonString);

import 'dart:convert';

OauthResponse oauthResponseFromJson(String str) =>
    OauthResponse.fromJson(json.decode(str));

String oauthResponseToJson(OauthResponse data) => json.encode(data.toJson());

class OauthResponse {
  String token;
  StudentData studentData;
  bool isNew;

  OauthResponse({
    this.token,
    this.studentData,
    this.isNew,
  });

  factory OauthResponse.fromJson(Map<String, dynamic> json) =>
      new OauthResponse(
        token: json["token"],
        studentData: StudentData.fromJson(json["student_data"]),
        isNew: json["is_new"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "student_data": studentData.toJson(),
        "is_new": isNew,
      };
}

class StudentData {
  String email;
  String hostelName;
  String hostelCode;
  String roomNo;
  int enrNo;
  String name;
  String contactNo;
  String branch;
  dynamic imageUrl;
  bool isCheckedOut;
  int lastUpdated;
  int leavesLeft;
  DateTime dob;
  String gender;
  String degree;
  int admissionYear;
  String role;

  StudentData({
    this.email,
    this.hostelName,
    this.hostelCode,
    this.roomNo,
    this.enrNo,
    this.name,
    this.contactNo,
    this.branch,
    this.imageUrl,
    this.isCheckedOut,
    this.lastUpdated,
    this.leavesLeft,
    this.dob,
    this.gender,
    this.degree,
    this.admissionYear,
    this.role,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) => new StudentData(
        email: json["email"],
        hostelName: json["hostel_name"],
        hostelCode: json["hostel_code"],
        roomNo: json["room_no"],
        enrNo: json["enr_no"],
        name: json["name"],
        contactNo: json["contact_no"],
        branch: json["branch"],
        imageUrl: json["image_url"],
        isCheckedOut: json["is_checked_out"],
        lastUpdated: json["last_updated"],
        leavesLeft: json["leaves_left"],
        dob: DateTime.parse(json["dob"]),
        gender: json["gender"],
        degree: json["degree"],
        admissionYear: json["admission_year"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "hostel_name": hostelName,
        "hostel_code": hostelCode,
        "room_no": roomNo,
        "enr_no": enrNo,
        "name": name,
        "contact_no": contactNo,
        "branch": branch,
        "image_url": imageUrl,
        "is_checked_out": isCheckedOut,
        "last_updated": lastUpdated,
        "leaves_left": leavesLeft,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "degree": degree,
        "admission_year": admissionYear,
        "role": role,
      };
}
