import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:appetizer_revamp_parts/models/menu/week_menu.dart';
import 'package:appetizer_revamp_parts/ui/components/round_edge_container.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/YourMealMenuCard/bloc/your_meal_menu_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fswitch_nullsafety/fswitch_nullsafety.dart';
import 'package:intl/intl.dart';

class YourMealMenuCard extends StatefulWidget {
  const YourMealMenuCard(
      {super.key, required this.meal, required this.dailyItems});
  final Meal meal;
  final List<MealItem> dailyItems;

  @override
  State<YourMealMenuCard> createState() => _YourMealMenuCardState();
}

bool _isMealValidForCoupon(Meal meal) {
  for (MealItem item in meal.items) {
    if (item.type == MealItemType.CPN) {
      return true;
    }
  }
  return false;
}

class _YourMealMenuCardState extends State<YourMealMenuCard> {
  late List<String> dailyItemsParsed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => YourMealMenuCardBloc(meal: widget.meal),
      child: BlocBuilder<YourMealMenuCardBloc, YourMealMenuCardState>(
        builder: (context, state) {
          if (state is YourMealMenuCardLoadingState) {
          } else if (state is ShowSnackBarState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.text)));
          } else if (state is YourMealMenuCardDisplayState) {
            String dailyItemsParsed = '';
            for (MealItem item in widget.dailyItems) {
              dailyItemsParsed += '${item.name}, ';
            }
            dailyItemsParsed =
                dailyItemsParsed.substring(0, dailyItemsParsed.length - 2);
            return Container(
              width: 312,
              height: 168,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: AppTheme.customWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: const [
                  BoxShadow(
                    color: AppTheme.shadow,
                    blurRadius: 12,
                    offset: Offset(2, 2),
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 125,
                    height: 168,
                    // color: AppTheme.primary,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/meal_card/${state.meal.title}.png',
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 125,
                          height: 28,
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            state.meal.title,
                            style: AppTheme.headline1.copyWith(
                                fontSize: 20, color: AppTheme.black11),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 17,
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            '${DateFormat.jm().format(state.meal.startTime)} - ${DateFormat.jm().format(state.meal.endTime)}',
                            style: AppTheme.headline3.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: AppTheme.grey2f),
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              // width: 125,
                              // height: 20,
                              // alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 12),
                              child: Container(
                                // padding: EdgeInsets.zero,
                                height: 20,
                                width: 44,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: FSwitch(
                                    // value: mealSkipped,
                                    sliderColor: AppTheme.customWhite,
                                    openColor: AppTheme.black2e,
                                    height: 20,
                                    width: 44,
                                    onChanged: (value) {
                                      context.read<YourMealMenuCardBloc>().add(
                                            MealToggleEvent(context: context),
                                          );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //check the enums
                        SizedBox(
                          height: 47,
                        ),
                        ...[
                          state.meal.startDateTime.isBefore(
                            DateTime.now(),
                          )
                              ? GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    // padding: const EdgeInsets.only(left: 18),
                                    height: 24,
                                    width: 88,
                                    child: const MealCardButtonContainer(
                                        text: "Give Feedback"),
                                  ),
                                )
                              : (_isMealValidForCoupon(state.meal)
                                  ? GestureDetector(
                                      onTap: () {},
                                      child: const MealCardButtonContainer(
                                          text: "COUPON"),
                                    )
                                  : const SizedBox.shrink())
                        ],
                      ],
                    ),
                  ),
                  Container(
                    height: 168,
                    width: 187,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 80,
                          child: Column(children: [
                            SizedBox(
                              height: 18,
                            ),
                            for (var item in state.meal.items)
                              Text("\u2022 ${item.name}")
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 17),
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                indent: 22,
                                endIndent: 20,
                                color: AppTheme.rulerColor,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                width: 187,
                                padding: EdgeInsets.only(
                                    left: 12, right: 19, bottom: 0),
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Daily Items: ',
                                      style: AppTheme.bodyText2.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFB51111)),
                                      children: [
                                        TextSpan(
                                            text: dailyItemsParsed,
                                            style: AppTheme.bodyText2)
                                      ]),
                                ),
                              ),
                              // SizedBox(
                              //   height: 17,
                              // )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          throw Error();
        },
      ),
    );
  }
}
