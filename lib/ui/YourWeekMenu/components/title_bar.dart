import 'package:appetizer/app_theme.dart';
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
              SizedBox(
                width: 8,
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(1.57),
                child: Container(
                  width: 24,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.50,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Text(monthAndYear,
                  style: AppTheme.headline1.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                width: 6,
              ),
              Icon(
                Icons.calendar_today_outlined,
                color: AppTheme.white,
              ),
            ],
          ),
          Icon(Icons.notifications_none),
        ],
      ),
    );
  }
}
