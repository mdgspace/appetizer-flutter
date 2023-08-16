import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:appetizer_revamp_parts/models/menu/week_menu.dart';
import 'package:appetizer_revamp_parts/ui/YourWeekMenu/components/yourMealDailyCardsCombined/bloc/your_meal_daily_cards_combined_bloc.dart';
import 'package:appetizer_revamp_parts/ui/components/shadow_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fswitch_nullsafety/fswitch_nullsafety.dart';
import 'package:intl/intl.dart';

bool _isMealValidForCoupon(Meal meal) {
  for (MealItem item in meal.items) {
    if (item.type == MealItemType.CPN) {
      return true;
    }
  }
  return false;
}

class FeedbackAndCouponWidget extends StatelessWidget {
  const FeedbackAndCouponWidget({
    super.key,
    required this.taken,
    required this.coupon,
  });
  final bool taken, coupon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 88,
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: ShapeDecoration(
        color: AppTheme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...[
            coupon && taken
                ? SvgPicture.asset('assets/icons/coupon_taken_tick.svg')
                : const SizedBox.shrink()
          ],
          Text(coupon ? "COUPON" : "Give Feedback",
              style: AppTheme.button.copyWith(
                  height: 1,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.black11))
        ],
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.meal, required this.dailyItems});
  final Meal meal;
  final List<MealItem> dailyItems;

  @override
  Widget build(BuildContext context) {
    String dailyItemsParsed = '';
    for (MealItem item in dailyItems) {
      dailyItemsParsed += '${item.name}, ';
    }
    dailyItemsParsed =
        dailyItemsParsed.substring(0, dailyItemsParsed.length - 2);
    print("******************************");
    print(meal.isOutdated);
    print("******************************");
    return ShadowContainer(
      // padding: EdgeInsets.zero,
      offset: 2,
      width: 312,
      height: 168,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 125,
              height: 168,
              // color: AppTheme.primary,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/meal_card/${meal.title}.png',
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
                      meal.title,
                      style: AppTheme.headline1
                          .copyWith(fontSize: 20, color: AppTheme.black11),
                    ),
                  ),
                  Container(
                    width: 125,
                    height: 17,
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      '${DateFormat.jm().format(meal.startTime)} - ${DateFormat.jm().format(meal.endTime)}',
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
                        padding: const EdgeInsets.only(left: 12),
                        child: Container(
                          height: 20,
                          width: 44,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: FSwitch(
                              enable: !meal.isLeaveToggleOutdated,
                              open:
                                  meal.leaveStatus.status == LeaveStatusEnum.A,
                              sliderColor: AppTheme.customWhite,
                              openColor: AppTheme.black2e,
                              height: 20,
                              width: 44,
                              onChanged: (value) async {
                                context
                                    .read<YourMealDailyCardsCombinedBloc>()
                                    .add(ToggleMealLeaveEvent(
                                        mealId: meal.id,
                                        leaveAppliedAlready:
                                            meal.leaveStatus.status ==
                                                LeaveStatusEnum.A));
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 47,
                  ),
                  ...[
                    meal.isOutdated
                        ? GestureDetector(
                            onTap: () {
                              //TODO: lead to feedback page
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: 24,
                              width: 88,
                              child: FeedbackAndCouponWidget(
                                  taken: false, coupon: false),
                            ),
                          )
                        : (_isMealValidForCoupon(meal)
                            ? GestureDetector(
                                onTap: () {
                                  context
                                      .read<YourMealDailyCardsCombinedBloc>()
                                      .add(ToggleMealCouponEvent(
                                          couponId: meal.couponStatus.status ==
                                                  CouponStatusEnum.A
                                              ? meal.couponStatus.id!
                                              : -1,
                                          couponAppliedAlready:
                                              meal.couponStatus.status ==
                                                  CouponStatusEnum.A,
                                          mealId: meal.id));
                                },
                                child: FeedbackAndCouponWidget(
                                    taken: meal.couponStatus.status ==
                                        CouponStatusEnum.A,
                                    coupon: true),
                              )
                            : const SizedBox.shrink()),
                  ],
                ],
              ),
            ),
            Container(
              height: 168,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18),
                        for (var item in meal.items)
                          Text("  \u2022 ${item.name}")
                      ],
                    ),
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
                          padding:
                              EdgeInsets.only(left: 12, right: 19, bottom: 0),
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
            )
          ],
        ),
      ),
    );
  }
}
