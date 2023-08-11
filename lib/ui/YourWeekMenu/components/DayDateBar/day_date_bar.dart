import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:appetizer_revamp_parts/constants.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/bloc/your_week_menu_bloc_bloc.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/DayDateBar/bloc/day_date_bar_bloc.dart';
import 'package:intl/intl.dart';

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

class NewDayDateBar extends StatefulWidget {
  const NewDayDateBar(
      {super.key,
      required this.dates,
      required this.dateToMonthYear,
      required this.currDate});
  final int currDate;
  final List<int> dates;
  final Map<int, String> dateToMonthYear;

  @override
  State<NewDayDateBar> createState() => _NewDayDateBarState();
}

class _NewDayDateBarState extends State<NewDayDateBar> {
  int? currDate;
  List<int>? dates;
  Map<int, String>? dateToMonthYear;
  List<String>? dayNames = [
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
    currDate = widget.currDate;
    dates = widget.dates;
    dateToMonthYear = widget.dateToMonthYear;
    return SizedBox(
      width: 360,
      child: Column(
        children: [
          (DateFormat("dd ").format(DateTime.now()) +
                      DateFormat("MMM").format(DateTime.now()) +
                      "'" +
                      DateFormat("yy").format(DateTime.now()) ==
                  ((currDate).toString() + " " + dateToMonthYear![currDate]!))
              ? TitleBar(
                  monthAndYear: dateToMonthYear![currDate]!, dayName: "Today")
              : TitleBar(
                  monthAndYear: "",
                  dayName: ((currDate).toString() +
                      " " +
                      dateToMonthYear![currDate]!)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 12.5),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      currDate = dates![0];
                    });
                    context
                        .read<YourWeekMenuBlocBloc>()
                        .add(const DayChangeEvent(newDayIndex: 0));
                  },
                  child: currDate == dates![0]
                      ? _CurrDateWidget(date: dates![0], day: dayNames![0])
                      : _OtherDateWidget(
                          date: dates![0], day: dayNames![0 % 7])),
              for (int widgetDateOffset = 1;
                  widgetDateOffset < 7;
                  widgetDateOffset++)
                Row(
                  children: [
                    SizedBox(width: 15),
                    GestureDetector(
                      child: currDate == dates![widgetDateOffset]
                          ? _CurrDateWidget(
                              date: dates![widgetDateOffset],
                              day: dayNames![widgetDateOffset])
                          : _OtherDateWidget(
                              date: dates![widgetDateOffset],
                              day: dayNames![widgetDateOffset]),
                      onTap: () {
                        setState(() {
                          currDate = dates![widgetDateOffset];
                        });
                        context
                            .read<YourWeekMenuBlocBloc>()
                            .add(DayChangeEvent(newDayIndex: widgetDateOffset));
                      },
                    ),
                  ],
                ),
              SizedBox(width: 8.5),
            ],
          ),
        ],
      ),
    );
  }
}

class DayDateBar extends StatelessWidget {
  const DayDateBar(
      {super.key,
      required this.dates,
      required this.dateToMonthYear,
      required this.currDate});
  final int currDate;
  final List<int> dates;
  final Map<int, String> dateToMonthYear;

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
          dateToMonthYear: dateToMonthYear, dates: dates, currDate: currDate),
      child: BlocBuilder<DayDateBarBloc, DayDateBarState>(
        builder: (context, state) {
          return SizedBox(
            width: 360,
            child: Column(
              children: [
                (DateFormat("dd ").format(DateTime.now()) +
                            DateFormat("MMM").format(DateTime.now()) +
                            "'" +
                            DateFormat("yy").format(DateTime.now()) ==
                        ((state.currDate).toString() +
                            " " +
                            dateToMonthYear[state.currDate]!))
                    ? TitleBar(
                        monthAndYear: dateToMonthYear[state.currDate]!,
                        dayName: "Today")
                    : TitleBar(
                        monthAndYear: "",
                        dayName: ((state.currDate).toString() +
                            " " +
                            dateToMonthYear[state.currDate]!)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 12.5),
                    GestureDetector(
                        onTap: () {
                          context.read<DayDateBarBloc>().add(
                              DateChangeEvent(newCurrDate: state.dates[0]));
                          context
                              .read<YourWeekMenuBlocBloc>()
                              .add(DayChangeEvent(newDayIndex: 0));
                        },
                        child: state.currDate == state.dates[0]
                            ? _CurrDateWidget(
                                date: state.dates[0], day: dayNames[0])
                            : _OtherDateWidget(
                                date: state.dates[0], day: dayNames[0 % 7])),
                    for (int widgetDateOffset = 1;
                        widgetDateOffset < 7;
                        widgetDateOffset++)
                      Row(
                        children: [
                          SizedBox(width: 15),
                          GestureDetector(
                            child:
                                state.currDate == state.dates[widgetDateOffset]
                                    ? _CurrDateWidget(
                                        date: state.dates[widgetDateOffset],
                                        day: dayNames[widgetDateOffset])
                                    : _OtherDateWidget(
                                        date: state.dates[widgetDateOffset],
                                        day: dayNames[widgetDateOffset]),
                            onTap: () {
                              context.read<DayDateBarBloc>().add(
                                  DateChangeEvent(
                                      newCurrDate:
                                          state.dates[widgetDateOffset]));
                              context.read<YourWeekMenuBlocBloc>().add(
                                  DayChangeEvent(
                                      newDayIndex: widgetDateOffset));
                            },
                          ),
                        ],
                      ),
                    SizedBox(width: 8.5),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
