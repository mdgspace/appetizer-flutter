import 'package:appetizer/colors.dart';
import 'package:appetizer/models/menu/week.dart';
import 'package:flutter/material.dart';

Color getLeaveColorFromLeaveStatus(LeaveStatusEnum ls) {
  switch (ls) {
    case LeaveStatusEnum.N:
      return Colors.white;
      break;
    case LeaveStatusEnum.A:
      return Colors.green;
      break;
    case LeaveStatusEnum.D:
      return Colors.red;
      break;
    case LeaveStatusEnum.P:
      return appiYellow;
      break;
    case LeaveStatusEnum.U:
      return Colors.blue;
      break;
    default:
      return Colors.white;
  }
}
