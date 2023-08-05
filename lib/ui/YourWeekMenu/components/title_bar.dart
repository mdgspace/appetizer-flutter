import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({
    super.key,
    required this.monthAndYear,
    required this.dayName,
  });
  final String monthAndYear, dayName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(dayName, style: AppTheme.headline1),
              VerticalDivider(thickness: 1, width: 24, color: AppTheme.white),
              Text(monthAndYear,
                  style: AppTheme.headline1.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              Icon(Icons.calendar_today_outlined),
            ],
          ),
          Icon(Icons.notifications_none),
        ],
      ),
    );
  }
}
