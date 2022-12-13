import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String email;
  String hostelName;
  String hostelCode;
  String? roomNo;
  int enrNo;
  String name;
  String contactNo;
  String? branch;
  dynamic imageUrl;
  bool isCheckedOut;
  int? lastUpdated;
  int? leavesLeft;
  dynamic dob;
  String? gender;
  dynamic degree;
  dynamic admissionYear;
  String? role;
  String? token;
  bool isNew;

  User({
    required this.email,
    required this.hostelName,
    required this.hostelCode,
    this.roomNo,
    required this.enrNo,
    required this.name,
    required this.contactNo,
    required this.branch,
    required this.imageUrl,
    required this.isCheckedOut,
    this.lastUpdated,
    this.leavesLeft,
    required this.dob,
    this.gender,
    required this.degree,
    required this.admissionYear,
    this.role,
    this.token,
    required this.isNew,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json['email'],
        hostelName: json['hostel_name'],
        hostelCode: json['hostel_code'],
        roomNo: json['room_no'],
        enrNo: json['enr_no'],
        name: json['name'],
        contactNo: json['contact_no'],
        branch: json['branch'],
        imageUrl: json['image_url'],
        isCheckedOut: json['is_checked_out'] ?? false,
        lastUpdated: json['last_updated'],
        leavesLeft: json['leaves_left'],
        dob: json['dob'],
        gender: json['gender'],
        degree: json['degree'],
        admissionYear: json['admission_year'],
        role: json['role'],
        token: json['token'],
        isNew: json['is_new'] ?? true,
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
