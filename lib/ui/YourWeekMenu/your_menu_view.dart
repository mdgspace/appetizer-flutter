// import 'package:appetizer_revamp_parts/constants.dart';
import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:appetizer_revamp_parts/models/menu/week_menu.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/bloc/your_week_menu_bloc_bloc.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/day_date_bar.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/yourMealDailyCardsCombined/your_meal_daily_cards_combined.dart';
// import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/title_bar.dart';
import 'package:appetizer_revamp_parts/ui/components/app_banner.dart';
import 'package:appetizer_revamp_parts/ui/components/loading_indicator.dart';
import 'package:appetizer_revamp_parts/ui/components/round_edge_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

//index, date
List<int> getCurrDayAndIndex(WeekMenu weekMenu) {
  DateTime curr = DateTime.now();
  for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
    if (weekMenu.dayMenus[dayIndex].date.day == curr.day &&
        weekMenu.dayMenus[dayIndex].date.month == curr.month &&
        weekMenu.dayMenus[dayIndex].date.year == curr.year) {
      return [dayIndex, curr.day];
    }
  }
  return [0, weekMenu.dayMenus[0].date.day];
}

class DayMenuFull {
  const DayMenuFull({required this.dayMenu, required this.dailyItems});
  final DayMenu dayMenu;
  final DailyItems dailyItems;

  DayMenuFull copyWith(DayMenu? dayMenu, DailyItems? dailyItems) {
    return DayMenuFull(
        dayMenu: dayMenu ?? this.dayMenu,
        dailyItems: dailyItems ?? this.dailyItems);
  }
}

class YourWeekMenu extends StatelessWidget {
  const YourWeekMenu(
      {super.key, required this.weekMenu, required this.isCheckedOut});
  // final DateTime monthAndYear, startDateTime, endDateTime;
  final WeekMenu weekMenu;
  final bool isCheckedOut;
  @override
  Widget build(BuildContext context) {
    List<int> dates = [];
    Map<int, String> dateToMonthYear = {};
    for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
      dates.add(weekMenu.dayMenus[dayIndex].date.day);
      dateToMonthYear[weekMenu.dayMenus[dayIndex].date.day] =
          DateFormat("MMM").format(weekMenu.dayMenus[dayIndex].date) +
              "'" +
              DateFormat("yy").format(weekMenu.dayMenus[dayIndex].date);
    }
    final List<int> dayUtil = getCurrDayAndIndex(weekMenu);
    final int currDate = dayUtil[1], currDayIndex = dayUtil[0];
    return BlocProvider<YourWeekMenuBlocBloc>(
      create: (BuildContext context) => YourWeekMenuBlocBloc(
          weekMenu: weekMenu,
          currDayIndex: currDayIndex,
          isCheckedOut: isCheckedOut),
      child: BlocBuilder<YourWeekMenuBlocBloc, YourWeekMenuBlocState>(
        // listener: (context, state) {},
        // listenWhen: (previous, current) {
        //   return (previous != current);
        // },
        builder: (context, state) {
          if (state is YourWeekMenuBlocLoadingState) {
            return const Center(child: LoadingIndicator());
          }
          if (state is YourWeekMenuBlocDisplayState) {
            return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      AppBanner(
                        height: 146,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            GestureDetector(
                              onPanUpdate: ((details) {
                                // Swiping in right direction.
                                if (details.delta.dx > 0) {
                                  // move to previous week
                                  context.read<YourWeekMenuBlocBloc>().add(
                                        PreviousWeekChangeEvent(
                                          previousWeekId:
                                              state.weekMenu.weekId - 1,
                                        ),
                                      );
                                }
                                // Swiping in left direction.
                                if (details.delta.dx < 0) {
                                  context.read<YourWeekMenuBlocBloc>().add(
                                        NextWeekChangeEvent(
                                          nextWeekId: state.weekMenu.weekId + 1,
                                        ),
                                      );
                                }
                              }),
                              child: NewDayDateBar(
                                currDate: dates[state.currDayIndex],
                                dates: dates,
                                dateToMonthYear: dateToMonthYear,
                                blocObj: context.read<YourWeekMenuBlocBloc>(),
                              ),
                            ),
                            // YourMealDailyCardsCombined(
                            //   dayMenu:
                            //       weekMenu.dayMenus[state.currDayIndex],
                            //   dailyItems: weekMenu.dailyItems,
                            // ),
                          ],
                        ),
                      ),
                      // DayDateBar(
                      //   dates: dates,
                      //   dateToMonthYear: dateToMonthYear,
                      //   currDate: currDate,
                      // ),
                      if (isCheckedOut) ...[
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                          child: Text(
                            "You are currently checked-out",
                            style: AppTheme.bodyText1.copyWith(
                                fontFamily: 'Noto Sans',
                                fontSize: 14,
                                color: AppTheme.customRed),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                          child: GestureDetector(
                            onTap: () {
                              //TODO: add check in functionality
                            },
                            child: RoundEdgeTextOnlyContainer(text: "CHECK IN"),
                          ),
                        )
                      ],
                      // BlocSelector<YourWeekMenuBlocBloc, YourWeekMenuBlocState,
                      //     DayMenuFull>(
                      //   selector: (state) => DayMenuFull(
                      //       dayMenu: weekMenu.dayMenus[currDayIndex],
                      //       dailyItems: weekMenu.dailyItems),
                      //   builder: (context, state) {
                      //     return
                      Container(
                        height: 423,
                        child: SingleChildScrollView(
                          child: YourMealDailyCardsCombined(
                              dayMenu:
                                  state.weekMenu.dayMenus[state.currDayIndex],
                              dailyItems: state.weekMenu.dailyItems),
                        ),
                      ) //;
                      // },
                      // ),
                    ],
                  ),
                  if (!isCheckedOut) ...[
                    Column(
                      children: [
                        GestureDetector(
                          child: RoundEdgeTextOnlyContainer(text: "CHECK OUT"),
                          onTap: () {
                            context
                                .read<YourWeekMenuBlocBloc>()
                                .add(const CheckOutEvent());
                          }, // TODO: add checkout functionality
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    )
                  ]
                ]);
          } else {
            // TODO: ask for final confirmation with designers
            return const Center(
                child: Text(
                    "Some error has occured, kindly contact technical support"));
          }
        },
      ),
    );
  }
}
