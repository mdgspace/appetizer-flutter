import 'package:appetizer/app_theme.dart';
import 'package:appetizer/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appetizer/ui/menu/components/DayDateBar/bloc/day_date_bar_bloc.dart';

class _CurrDateWidget extends StatelessWidget {
  const _CurrDateWidget({required this.date, required this.day});
  final int date;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 33,
      height: 53,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      decoration: ShapeDecoration(
        color: AppTheme.black2e,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 14,
            child: Text(
              Constants.dayToInitial[day]!,
              style: AppTheme.button.copyWith(height: 1),
            ),
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5.5),
            decoration: ShapeDecoration(
              color: AppTheme.customWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            height: 25,
            child: Center(
              child: Text(
                date.toString(),
                style: AppTheme.button
                    .copyWith(color: AppTheme.black1e, height: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtherDateWidget extends StatelessWidget {
  const _OtherDateWidget({required this.date, required this.day});
  final int date;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 33,
      height: 53,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 14,
            child: Text(
              Constants.dayToInitial[day]!,
              style: AppTheme.button.copyWith(height: 1),
            ),
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.5, horizontal: 6),
            decoration: ShapeDecoration(
              color: AppTheme.customWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            height: 25,
            child: Center(
              child: Text(
                date.toString(),
                style: AppTheme.button
                    .copyWith(color: AppTheme.black1e, height: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DayDateBar extends StatelessWidget {
  const DayDateBar(
      {super.key,
      required this.startDate,
      required this.startDay,
      required this.endDate,
      required this.currDate});
  final int startDate, endDate, currDate;
  final String startDay;

  static const List<String> dayNames = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DayDateBarBloc(
          endDate: endDate,
          startDate: startDate,
          currDate: currDate,
          startDay: startDay),
      child: BlocBuilder<DayDateBarBloc, DayDateBarState>(
        builder: (context, state) {
          int startDayIndex = 0;
          while (startDayIndex < 7) {
            if (dayNames[startDayIndex] == startDay) break;
            startDayIndex++;
          }
          return SizedBox(
            width: 360,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 12.5),
                for (int widgetDateOffset = 0;
                    startDate + widgetDateOffset <= state.endDate;
                    widgetDateOffset++)
                  GestureDetector(
                    child: state.currDate == state.startDate + widgetDateOffset
                        ? _CurrDateWidget(
                            date: state.startDate + widgetDateOffset,
                            day: dayNames[
                                (startDayIndex + widgetDateOffset) % 7])
                        : _OtherDateWidget(
                            date: state.startDate + widgetDateOffset,
                            day: dayNames[
                                (startDayIndex + widgetDateOffset) % 7]),
                    onTap: () {
                      context.read<DayDateBarBloc>().add(DateChangeEvent(
                          newCurrDate: state.startDate + widgetDateOffset));
                    },
                  ),
                SizedBox(width: 8.5),
              ],
            ),
          );
        },
      ),
    );
  }
}
