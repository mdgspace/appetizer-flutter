import 'package:appetizer/models/user/login.dart';
import 'package:appetizer/models/user/me.dart';

class UserDetailsUtils {
  static Login getLoginModelFromMe(Me userDetails) {
    return Login(
      email: userDetails.email,
      hostelName: userDetails.hostelName,
      hostelCode: userDetails.hostelCode,
      roomNo: userDetails.roomNo,
      enrNo: userDetails.enrNo,
      name: userDetails.name,
      contactNo: userDetails.contactNo,
      branch: userDetails.branch,
      imageUrl: userDetails.imageUrl,
      isCheckedOut: userDetails.isCheckedOut,
      lastUpdated: userDetails.lastUpdated,
      leavesLeft: userDetails.leavesLeft,
      dob: userDetails.dob,
      gender: userDetails.gender,
      degree: userDetails.degree,
      admissionYear: userDetails.admissionYear,
      role: userDetails.role,
    );
  }
}
