// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
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
  dynamic dob;
  String gender;
  dynamic degree;
  dynamic admissionYear;
  String role;
  String token;
  bool isNew;

  Login({
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
    this.token,
    this.isNew,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json['email'],
        hostelName: json['hostel_name'],
        hostelCode: json['hostel_code'],
        roomNo: json['room_no'],
        enrNo: json['enr_no'],
        name: json['name'],
        contactNo: json['contact_no'],
        branch: json['branch'],
        imageUrl: json['image_url'],
        isCheckedOut: json['is_checked_out'],
        lastUpdated: json['last_updated'],
        leavesLeft: json['leaves_left'],
        dob: json['dob'],
        gender: json['gender'],
        degree: json['degree'],
        admissionYear: json['admission_year'],
        role: json['role'],
        token: json['token'],
        isNew: json['is_new'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'hostel_name': hostelName,
        'hostel_code': hostelCode,
        'room_no': roomNo,
        'enr_no': enrNo,
        'name': name,
        'contact_no': contactNo,
        'branch': branch,
        'image_url': imageUrl,
        'is_checked_out': isCheckedOut,
        'last_updated': lastUpdated,
        'leaves_left': leavesLeft,
        'dob': dob,
        'gender': gender,
        'degree': degree,
        'admission_year': admissionYear,
        'role': role,
        'token': token,
        'is_new': isNew,
      };
}
