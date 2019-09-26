import 'package:appetizer/colors.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:flutter/material.dart';

Color getLeaveColorFromLeaveStatus(LeaveStatus ls) {
  switch (ls) {
    case LeaveStatus.N:
      return Colors.white;
      break;
    case LeaveStatus.A:
      return Colors.green;
      break;
    case LeaveStatus.D:
      return Colors.red;
      break;
    case LeaveStatus.P:
      return appiYellow;
      break;
    case LeaveStatus.U:
      return Colors.blue;
      break;
    default:
      return Colors.white;
  }
}
