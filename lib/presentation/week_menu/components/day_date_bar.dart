import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/week_menu/bloc/week_menu_bloc.dart';
import 'package:appetizer/presentation/week_menu/components/title_bar.dart';
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
          SizedBox(height: 2.toAutoScaledHeight),
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
          2.toVerticalSizedBox,
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

class NewDayDateBar extends StatefulWidget {
  const NewDayDateBar({super.key});

  @override
  State<NewDayDateBar> createState() => _NewDayDateBarState();
}

class _NewDayDateBarState extends State<NewDayDateBar> {
  late int currDate;
  late DateTime currentDate;
  late List<DateTime> dates;
  Map<int, String>? dateToMonthYear;

  List<String> dayNames = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void initState() {
    currentDate = DateTime.now();
    DateTime tmp = currentDate;
    dates = List<DateTime>.filled(7, tmp);
    for (var i = tmp.weekday - 1; i >= 1; i--) {
      dates[i - 1] = tmp.subtract(Duration(days: (tmp.weekday - i)));
    }
    dates[tmp.weekday - 1] = tmp;
    for (var i = tmp.weekday + 1; i >= 7; i++) {
      dates[i - 1] = tmp.add(Duration(days: (i - tmp.weekday)));
    }
    super.initState();
  }

  bool isSameDay(DateTime d1, DateTime d2) {
    return d1.day == d2.day && d1.month == d2.month && d1.year == d2.year;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isSameDay(currentDate, DateTime.now())
            ? TitleBar(
                monthAndYear: DateFormat("MMM''yy").format(currentDate),
                dayName: "Today")
            : TitleBar(
                monthAndYear: "",
                dayName: DateFormat("dd MMM''yy").format(currentDate),
              ),
        16.toVerticalSizedBox,
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              12.5.toHorizontalSizedBox,
              GestureDetector(
                  onTap: () {
                    setState(() {
                      currentDate = dates[0];
                    });
                    context
                        .read<WeekMenuBlocBloc>()
                        .add(const DayChangeEvent(newDayIndex: 0));
                  },
                  child: isSameDay(currentDate, dates[0])
                      ? _CurrDateWidget(date: dates[0].day, day: dayNames[0])
                      : _OtherDateWidget(
                          date: dates[0].day, day: dayNames[0 % 7])),
              for (int widgetDateOffset = 1;
                  widgetDateOffset < 7;
                  widgetDateOffset++)
                Row(
                  children: [
                    15.toHorizontalSizedBox,
                    GestureDetector(
                      child: isSameDay(currentDate, dates[widgetDateOffset])
                          ? _CurrDateWidget(
                              date: dates[widgetDateOffset].day,
                              day: dayNames[widgetDateOffset])
                          : _OtherDateWidget(
                              date: dates[widgetDateOffset].day,
                              day: dayNames[widgetDateOffset]),
                      onTap: () {
                        setState(() {
                          currentDate = dates[widgetDateOffset];
                        });
                        context
                            .read<WeekMenuBlocBloc>()
                            .add(DayChangeEvent(newDayIndex: widgetDateOffset));
                      },
                    ),
                  ],
                ),
              8.5.toHorizontalSizedBox,
            ],
          ),
        ),
      ],
    );
  }
}

// class DayDateBar extends StatelessWidget {
//   const DayDateBar(
//       {super.key,
//       required this.dates,
//       required this.dateToMonthYear,
//       required this.currDate});
//   final int currDate;
//   final List<int> dates;
//   final Map<int, String> dateToMonthYear;

//   static const List<String> dayNames = [
//     "Monday",
//     "Tuesday",
//     "Wednesday",
//     "Thursday",
//     "Friday",
//     "Saturday",
//     "Sunday"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => DayDateBarBloc(
//           dateToMonthYear: dateToMonthYear, dates: dates, currDate: currDate),
//       child: BlocBuilder<DayDateBarBloc, DayDateBarState>(
//         builder: (context, state) {
//           return SizedBox(
//             width: 360,
//             child: Column(
//               children: [
//                 (DateFormat("dd ").format(DateTime.now()) +
//                             DateFormat("MMM").format(DateTime.now()) +
//                             "'" +
//                             DateFormat("yy").format(DateTime.now()) ==
//                         ((state.currDate).toString() +
//                             " " +
//                             dateToMonthYear[state.currDate]!))
//                     ? TitleBar(
//                         monthAndYear: dateToMonthYear[state.currDate]!,
//                         dayName: "Today")
//                     : TitleBar(
//                         monthAndYear: "",
//                         dayName: ((state.currDate).toString() +
//                             " " +
//                             dateToMonthYear[state.currDate]!)),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     SizedBox(width: 12.5),
//                     GestureDetector(
//                         onTap: () {
//                           context.read<DayDateBarBloc>().add(
//                               DateChangeEvent(newCurrDate: state.dates[0]));
//                           context
//                               .read<YourWeekMenuBlocBloc>()
//                               .add(DayChangeEvent(newDayIndex: 0));
//                         },
//                         child: state.currDate == state.dates[0]
//                             ? _CurrDateWidget(
//                                 date: state.dates[0], day: dayNames[0])
//                             : _OtherDateWidget(
//                                 date: state.dates[0], day: dayNames[0 % 7])),
//                     for (int widgetDateOffset = 1;
//                         widgetDateOffset < 7;
//                         widgetDateOffset++)
//                       Row(
//                         children: [
//                           SizedBox(width: 15),
//                           GestureDetector(
//                             child:
//                                 state.currDate == state.dates[widgetDateOffset]
//                                     ? _CurrDateWidget(
//                                         date: state.dates[widgetDateOffset],
//                                         day: dayNames[widgetDateOffset])
//                                     : _OtherDateWidget(
//                                         date: state.dates[widgetDateOffset],
//                                         day: dayNames[widgetDateOffset]),
//                             onTap: () {
//                               context.read<DayDateBarBloc>().add(
//                                   DateChangeEvent(
//                                       newCurrDate:
//                                           state.dates[widgetDateOffset]));
//                               context.read<YourWeekMenuBlocBloc>().add(
//                                   DayChangeEvent(
//                                       newDayIndex: widgetDateOffset));
//                             },
//                           ),
//                         ],
//                       ),
//                     SizedBox(width: 8.5),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
