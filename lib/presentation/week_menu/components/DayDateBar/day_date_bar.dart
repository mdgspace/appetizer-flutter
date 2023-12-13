import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/week_menu/bloc/week_menu_bloc.dart';
import 'package:appetizer/presentation/week_menu/components/DayDateBar/bloc/day_date_bar_bloc.dart';
import 'package:appetizer/presentation/week_menu/components/title_bar.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class _CurrDateWidget extends StatelessWidget {
  const _CurrDateWidget({required this.date, required this.day});
  final int date;
  final String day;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 33.toAutoScaledWidth,
      height: 53.toAutoScaledHeight,
      padding: EdgeInsets.symmetric(
          horizontal: 5.toAutoScaledWidth, vertical: 6.toAutoScaledHeight),
      decoration: ShapeDecoration(
        color: AppTheme.black2e,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.toAutoScaledWidth),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 14.toAutoScaledHeight,
            child: Text(
              day[0],
              style: AppTheme.button.copyWith(height: 1.toAutoScaledHeight),
            ),
          ),
          SizedBox(height: 1.toAutoScaledHeight),
          Container(
            decoration: ShapeDecoration(
              color: AppTheme.customWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.toAutoScaledWidth),
              ),
            ),
            height: 25.toAutoScaledHeight,
            child: Center(
              child: Text(
                date.toString(),
                style: AppTheme.button.copyWith(
                    color: AppTheme.black1e, height: 1.toAutoScaledHeight),
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
      width: 33.toAutoScaledWidth,
      height: 53.toAutoScaledHeight,
      padding: EdgeInsets.symmetric(
          horizontal: 5.toAutoScaledWidth, vertical: 6.toAutoScaledHeight),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.toAutoScaledWidth),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 14.toAutoScaledHeight,
            child: Text(
              day[0],
              style: AppTheme.button.copyWith(height: 1.toAutoScaledHeight),
            ),
          ),
          1.toVerticalSizedBox,
          Container(
            decoration: ShapeDecoration(
              color: AppTheme.customWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.toAutoScaledWidth),
              ),
            ),
            height: 25.toAutoScaledHeight,
            child: Center(
              child: Text(
                date.toString(),
                style: AppTheme.button.copyWith(
                    color: AppTheme.black1e, height: 1.toAutoScaledHeight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayDateBarPage extends StatelessWidget {
  const _DayDateBarPage({
    required this.startDate,
    required this.parentState,
  });
  _DayDatePage({Key? key}) : super(key: key);

  final PageController _pageController = PageController(initialPage: 3);

  final DateTime startDate;
  final DayDateBarState parentState;

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < 7; i++) ...[
          if (DateTimeUtils.compareDate(
            startDate.add(Duration(days: i)),
            parentState.date,
          ))
            _CurrDateWidget(
              date: startDate.add(Duration(days: i)).day,
              day: dayNames[startDate.add(Duration(days: i)).weekday - 1],
            )
          else
            GestureDetector(
              onTap: () {
                DateTime newDate = startDate.add(Duration(days: i));
                context.read<DayDateBarBloc>().add(
                      DayDateBarChangedEvent(
                        newDate: newDate,
                      ),
                    );
                context.read<WeekMenuBlocBloc>().add(
                      (DateTimeUtils.getWeekNumber(newDate) !=
                              DateTimeUtils.getWeekNumber(parentState.date))
                          ? DateChangeEvent(
                              dayIndex: newDate.weekday - 1,
                              weekId: DateTimeUtils.getWeekNumber(newDate),
                            )
                          : DayChangeEvent(
                              newDayIndex: newDate.weekday - 1,
                            ),
                    );
              },
              child: _OtherDateWidget(
                date: startDate.add(Duration(days: i)).day,
                day: dayNames[startDate.add(Duration(days: i)).weekday - 1],
              ),
            ),
        ],
      ],
    );
  }
}

class DayDateBar extends StatelessWidget {
  DayDateBar({Key? key}) : super(key: key);

  final PageController _pageController = PageController(initialPage: 3);
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DayDateBarBloc(),
      child: BlocBuilder<DayDateBarBloc, DayDateBarState>(
        builder: (context, state) {
          return Column(
            children: [
              DateTimeUtils.compareDate(state.date, DateTime.now())
                  ? TitleBar(
                      monthAndYear: DateFormat("MMM''yy").format(state.date),
                      dayName: "Today")
                  : TitleBar(
                      monthAndYear: "",
                      dayName: DateFormat("dd MMM''yy").format(state.date),
                    ),
              16.toVerticalSizedBox,
              Expanded(
                // height: 53.toAutoScaledHeight,
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return _DayDateBarPage(
                      parentState: state,
                      startDate: DateTimeUtils.getWeekStartDate(
                          DateTime.now().add(Duration(days: (index - 3) * 7))),
                    );
                  },
                  controller: _pageController,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


// make two events --> one for day and date 
