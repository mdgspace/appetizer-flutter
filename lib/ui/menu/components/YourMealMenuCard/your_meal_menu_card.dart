import 'package:appetizer/app_theme.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/menu/components/YourMealMenuCard/bloc/your_meal_menu_card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:flutter/cupertino.dart' as cupertino;

class YourMealMenuCard extends StatelessWidget {
  YourMealMenuCard({super.key, required this.weekMenu});
  final WeekMenu weekMenu;
  late List<String> dailyItemsParsed;
  late List<MealItem> dailyItems;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => YourMealMenuCardBloc(),
      child: BlocBuilder<YourMealMenuCardBloc, YourMealMenuCardState>(
        builder: (context, state) {
          bool mealSkipped;
          if (state is YourMealMenuCardLoadingState) {
          } else if (state is YourMealMenuCardDisplayState) {
            mealSkipped = state.meal.leaveStatus.status == LeaveStatusEnum.A;
            if (state.meal.type == MealType.B) {
              dailyItems = weekMenu.dailyItems.breakfast;
            } else if (state.meal.type == MealType.D) {
              dailyItems = weekMenu.dailyItems.dinner;
            } else if (state.meal.type == MealType.L) {
              dailyItems = weekMenu.dailyItems.lunch;
            } else {
              dailyItems = weekMenu.dailyItems.snack;
            }
            String dailyItemsParsed = '';
            for (MealItem item in dailyItems) {
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
                    color: AppTheme.primary,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/${state.meal.title}.png',
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
                            style: AppTheme.headline2.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          width: 125,
                          height: 17,
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            '${DateFormat.jm().format(state.meal.startTime)} - ${DateFormat.jm().format(state.meal.endTime)}',
                            style: AppTheme.headline2.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                          width: 125,
                          height: 20,
                          padding: const EdgeInsets.only(left: 12),
                          child: cupertino.CupertinoSwitch(
                            value: mealSkipped,
                            onChanged: (value) {
                              context.read<YourMealMenuCardBloc>().add(
                                    const MealToggleEvent(),
                                  );
                            },
                            activeColor: const Color(
                              0x2F2F2FFF,
                            ),
                            trackColor: const Color(
                              0xB9B9B9FF,
                            ),
                            thumbColor: Colors.white,
                          ),
                        ),
                        //check the enums
                        SizedBox(
                          height: 47,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 18),
                          child: state.meal.startDateTime.isBefore(
                            DateTime.now(),
                          )
                              ? FloatingActionButton.extended(
                                  onPressed: () {},
                                  label: Text(
                                    "Give Feedback",
                                    style: AppTheme.button,
                                  ),
                                )
                              : (state.meal.couponStatus.status ==
                                      CouponStatusEnum.A
                                  ? FloatingActionButton.extended(
                                      onPressed: () {},
                                      label: Text(
                                        "COUPON",
                                        style: AppTheme.button,
                                      ),
                                    )
                                  : null),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 168,
                    width: 187,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 18,
                        ),
                        for (var item in state.meal.items)
                          Text("\u2022${item.name}"),
                        Container(
                          padding: EdgeInsets.only(bottom: 17),
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                indent: 22,
                                endIndent: 20,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                width: 187,
                                padding: EdgeInsets.only(left: 12, right: 19),
                                child: RichText(
                                  text: TextSpan(
                                      text: 'Daily Items: ',
                                      style: AppTheme.bodyText2.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffB51111)),
                                      children: [
                                        TextSpan(
                                            text: dailyItemsParsed,
                                            style: AppTheme.bodyText2)
                                      ]),
                                ),
                              )
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
