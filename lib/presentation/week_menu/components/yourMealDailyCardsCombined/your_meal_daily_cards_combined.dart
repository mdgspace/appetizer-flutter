// just combine three cards into one
// pass just the daily meal to it

import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/menu/week_menu_tmp.dart';
import 'package:appetizer/domain/repositories/coupon_repository.dart';
import 'package:appetizer/domain/repositories/leave/leave_repository.dart';
import 'package:appetizer/presentation/week_menu/components/yourMealDailyCardsCombined/menu_card.dart';
import 'package:appetizer/presentation/week_menu/components/yourMealDailyCardsCombined/bloc/your_meal_daily_cards_combined_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YourMealDailyCardsCombined extends StatelessWidget {
  const YourMealDailyCardsCombined(
      {super.key, required this.dayMenu, required this.dailyItems});

  final DayMenu dayMenu;
  final DailyItems dailyItems;

  @override
  Widget build(BuildContext context) {
    List<MealState> initialMealStates = [];
    for (Meal meal in dayMenu.meals) {
      initialMealStates.add(MealState(
          mealId: meal.id,
          leaveAppliedAndApproved: meal.leaveStatus.status == LeaveStatusEnum.A,
          couponApplied: meal.couponStatus.status == CouponStatusEnum.A));
    }
    return BlocProvider(
      create: (_) => YourMealDailyCardsCombinedBloc(
        mealStatesInitial: initialMealStates,
        leaveRepository: context.read<LeaveRepository>(),
        couponRepository: context.read<CouponRepository>(),
      ),
      child: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: dayMenu.meals
                .map(
                  (meal) => Padding(
                    padding: EdgeInsets.only(
                      bottom: (meal == dayMenu.meals.last ? 0 : 24)
                          .toAutoScaledHeight,
                    ),
                    child: BlocSelector<YourMealDailyCardsCombinedBloc,
                        YourMealDailyCardsDisplayState, MealState>(
                      selector: (state) =>
                          state.mealStates[dayMenu.meals.indexOf(meal)],
                      builder: (context, state) {
                        return MealCard(
                          dailyItems: meal.type == MealType.B
                              ? dailyItems.breakfast
                              : (meal.type == MealType.L
                                  ? dailyItems.lunch
                                  : (meal.type == MealType.D
                                      ? dailyItems.dinner
                                      : dailyItems.snack)),
                          meal: meal,
                        );
                      },
                    ),
                  ),
                )
                .toList()
            // [
            //   (dayMenu.mealMap[MealType.B] != null
            //       ? Padding(
            //           padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
            //           child: BlocSelector<
            //               YourMealDailyCardsCombinedBloc,
            //               YourMealDailyCardsDisplayState,
            //               MealState>(
            //             selector: (state) => state.mealStates[0],
            //             builder: (context, state) {
            //               return MealCard(
            //                 dailyItems: dailyItems.breakfast,
            //                 meal: dayMenu.mealMap[MealType.B]!,
            //               );
            //             },
            //           ),
            //         )
            //       : Container(
            //           width: 125,
            //           height: 168,
            //           child:
            //               Text("The menu for this meal hasn't been uploaded yet!"),
            //         )),
            //   (dayMenu.mealMap[MealType.L] != null
            //       ? Padding(
            //           padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
            //           child: MealCard(
            //               dailyItems: dailyItems.lunch,
            //               meal: dayMenu.mealMap[MealType.L]!),
            //         )
            //       : Container(
            //           width: 125,
            //           height: 168,
            //           child:
            //               Text("The menu for this meal hasn't been uploaded yet!"),
            //         )),
            //   SizedBox(height: 24),
            //   dayMenu.mealMap[MealType.S] != null
            //       ? MealCard(
            //           dailyItems: dailyItems.snack,
            //           meal: dayMenu.mealMap[MealType.S]!,
            //         )
            //       : SizedBox.shrink(),
            //   (dayMenu.mealMap[MealType.D] != null
            //       ? MealCard(
            //           dailyItems: dailyItems.dinner,
            //           meal: dayMenu.mealMap[MealType.D]!,
            //         )
            //       : Container(
            //           width: 125,
            //           height: 168,
            //           child:
            //               Text("The menu for this meal hasn't been uploaded yet!"),
            //         )),
            // ],
            ),
      ),
    );
  }
}
