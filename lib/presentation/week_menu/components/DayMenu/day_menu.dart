import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/presentation/week_menu/bloc/week_menu_bloc.dart';
import 'package:appetizer/domain/models/menu/week_menu_tmp.dart';
import 'package:appetizer/presentation/week_menu/components/DayMenu/menu_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayMenuWidget extends StatelessWidget {
  const DayMenuWidget({
    required this.parentState,
    Key? key,
  }) : super(key: key);

  final WeekMenuBlocDisplayState parentState;

  @override
  Widget build(BuildContext context) {
    DayMenu dayMenu = parentState.weekMenu.dayMenus[parentState.dayNumber];
    DailyItems dailyItems = parentState.weekMenu.dailyItems;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...dayMenu.meals
              .map(
                // Write logic for ordering meals in order of breakfast, lunch, dinner, snack
                (meal) => Padding(
                  padding: EdgeInsets.only(
                    bottom: 24.toAutoScaledHeight,
                  ),
                  child: MealCard(
                    dailyItems: meal.type == MealType.B
                        ? dailyItems.breakfast
                        : (meal.type == MealType.L
                            ? dailyItems.lunch
                            : (meal.type == MealType.D
                                ? dailyItems.dinner
                                : dailyItems.snack)),
                    meal: meal,
                  ),
                ),
              )
              .toList(),
          BlocSelector<AppBloc, AppState, bool>(
            selector: (state) => state.user!.isCheckedOut,
            builder: (context, val) {
              if (!val) {
                return 20.toVerticalSizedBox;
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
