// import 'package:appetizer/constants.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/YourWeekMenu/bloc/your_week_menu_bloc_bloc.dart';
import 'package:appetizer/ui/YourWeekMenu/components/DayDateBar/day_date_bar.dart';
import 'package:appetizer/ui/YourWeekMenu/components/your_meal_daily_cards_combined.dart';
// import 'package:appetizer/ui/YourWeekMenu/components/title_bar.dart';
import 'package:appetizer/ui/components/app_banner.dart';
import 'package:appetizer/ui/components/round_edge_container.dart';
import 'package:appetizer/ui/components/loading_indicator.dart';
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

class YourWeekMenu extends StatelessWidget {
  const YourWeekMenu({super.key, required this.weekMenu});
  // final DateTime monthAndYear, startDateTime, endDateTime;
  final WeekMenu weekMenu;
  @override
  Widget build(BuildContext context) {
    List<int> dates = [];
    Map<int, String> dateToMonthYear = {};
    for (int dayIndex = 0; dayIndex < 7; dayIndex++) {
      dates.add(weekMenu.dayMenus[dayIndex].date.day);
      dateToMonthYear[weekMenu.dayMenus[dayIndex].date.day] =
          DateFormat('MMM’yy').format(weekMenu.dayMenus[dayIndex].date);
    }
    final List<int> dayUtil = getCurrDayAndIndex(weekMenu);
    final int currDate = dayUtil[1], currDayIndex = dayUtil[0];
    return BlocProvider(
      create: (context) =>
          YourWeekMenuBlocBloc(weekMenu: weekMenu, currDayIndex: currDayIndex),
      child: BlocBuilder<YourWeekMenuBlocBloc, YourWeekMenuBlocState>(
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
                              child: DayDateBar(
                                currDate: currDate,
                                dates: dates,
                                dateToMonthYear: dateToMonthYear,
                              ),
                            ),
                            YourMealDailyCardsCombined(
                              dayMenu: weekMenu.dayMenus[state.currDayIndex],
                              dailyItems: weekMenu.dailyItems,
                            ),
                          ],
                        ),
                      ),
                      DayDateBar(
                        dates: dates,
                        dateToMonthYear: dateToMonthYear,
                        currDate: currDate,
                      ),
                      SingleChildScrollView(
                        child: YourMealDailyCardsCombined(
                            dayMenu: weekMenu.dayMenus[currDayIndex],
                            dailyItems: weekMenu.dailyItems),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: RoundEdgeTextOnlyContainer(text: "CHECK OUT"),
                        onTap: () {}, // TODO: add checkout functionality
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  )
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
