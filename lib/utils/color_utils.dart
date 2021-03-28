import 'package:appetizer/app_theme.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:flutter/material.dart';

class ColorUtils {
  static Color getLeaveColorFromLeaveStatus(LeaveStatusEnum ls) {
    switch (ls) {
      case LeaveStatusEnum.N:
        return AppTheme.white;
        break;
      case LeaveStatusEnum.A:
        return AppTheme.green;
        break;
      case LeaveStatusEnum.D:
        return AppTheme.red;
        break;
      case LeaveStatusEnum.P:
        return AppTheme.yellow;
        break;
      case LeaveStatusEnum.U:
        return AppTheme.blue;
        break;
      default:
        return AppTheme.white;
    }
  }
}
