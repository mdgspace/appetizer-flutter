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

  static Color getSwitchColorFromSwitchStatus(SwitchStatus switchStatus) {
    switch (switchStatus.status) {
      case SwitchStatusEnum.N:
        return Colors.transparent;
        break;
      case SwitchStatusEnum.A:
        return Colors.greenAccent;
        break;
      case SwitchStatusEnum.D:
        return Colors.redAccent;
        break;
      case SwitchStatusEnum.T:
      case SwitchStatusEnum.F:
        return AppTheme.primary;
        break;
      case SwitchStatusEnum.U:
        return AppTheme.grey;
        break;
      default:
        return Colors.transparent;
    }
  }
}
