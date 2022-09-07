import 'package:appetizer/app_theme.dart';
import '../models/menu/week_menu.dart';
import 'package:flutter/material.dart';

class ColorUtils {
  static Color getLeaveColorFromLeaveStatus(LeaveStatusEnum ls) {
    switch (ls) {
      case LeaveStatusEnum.N:
        return AppTheme.white;

      case LeaveStatusEnum.A:
        return AppTheme.green;

      case LeaveStatusEnum.D:
        return AppTheme.red;

      case LeaveStatusEnum.P:
        return AppTheme.secondary;

      case LeaveStatusEnum.U:
        return AppTheme.blue;

      default:
        return AppTheme.white;
    }
  }

  static Color getSwitchColorFromSwitchStatus(SwitchStatus switchStatus) {
    switch (switchStatus.status) {
      case SwitchStatusEnum.N:
        return Colors.transparent;

      case SwitchStatusEnum.A:
        return Colors.greenAccent;

      case SwitchStatusEnum.D:
        return Colors.redAccent;

      case SwitchStatusEnum.T:
      case SwitchStatusEnum.F:
        return AppTheme.primary;

      case SwitchStatusEnum.U:
        return AppTheme.grey;

      default:
        return Colors.transparent;
    }
  }
}
