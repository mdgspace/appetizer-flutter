import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/router/intrinsic_router/intrinsic_router.gr.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/week_menu/bloc/week_menu_bloc.dart';
import 'package:appetizer/presentation/week_menu/components/DayDateBar/bloc/day_date_bar_bloc.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                Text(
                  monthAndYear,
                  style: AppTheme.headline1.copyWith(
                    fontSize: 16.toAutoScaledFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.toHorizontalSizedBox,
                GestureDetector(
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2024),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: AppTheme.primary,
                              onPrimary: AppTheme.white,
                              surface: AppTheme.white,
                              onSurface: AppTheme.black1e,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: child ?? const SizedBox.shrink(),
                        );
                      },
                    );
                    if (newDate != null && context.mounted) {
                      context.read<DayDateBarBloc>().add(
                            DayDateBarChangedEvent(
                              newDate: newDate,
                            ),
                          );
                      context.read<WeekMenuBlocBloc>().add(DateChangeEvent(
                            dayIndex: newDate.weekday - 1,
                            weekId: DateTimeUtils.getWeekNumber(newDate),
                          ));
                    }
                  },
                  child: const Icon(
                    Icons.calendar_today_outlined,
                    color: AppTheme.white,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.router.push(const NotificationRoute()),
            child: SvgPicture.asset('assets/images/icons/Bell.svg'),
          ),
        ],
      ),
    );
  }
}
