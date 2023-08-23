import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      width: 360.toAutoScaledWidth,
      padding: EdgeInsets.symmetric(horizontal: 24.toAutoScaledWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Text(dayName, style: AppTheme.headline1),
                8.toHorizontalSizedBox,
                const VerticalDivider(
                  thickness: 1.5,
                  color: AppTheme.white,
                ),
                Text(monthAndYear,
                    style: AppTheme.headline1.copyWith(
                      fontSize: 16.toAutoScaledFont,
                      fontWeight: FontWeight.w600,
                    )),
                6.toHorizontalSizedBox,
                const Icon(
                  Icons.calendar_today_outlined,
                  color: AppTheme.white,
                ),
              ],
            ),
          ),
          SvgPicture.asset('assets/images/icons/Bell.svg'),
        ],
      ),
    );
  }
}
