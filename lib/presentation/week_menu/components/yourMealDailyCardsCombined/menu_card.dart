import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/menu/week_menu.dart';
import 'package:appetizer/presentation/week_menu/components/yourMealDailyCardsCombined/bloc/your_meal_daily_cards_combined_bloc.dart';
import 'package:appetizer/presentation/components/shadow_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
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
    return Center(
      child: Container(
        height: 24.toAutoScaledHeight,
        width: 88.toAutoScaledWidth,
        padding: EdgeInsets.symmetric(horizontal: 8.toAutoScaledWidth),
        decoration: ShapeDecoration(
          color: AppTheme.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (coupon && taken) ...[
              SvgPicture.asset('assets/icons/coupon_taken_tick.svg')
            ],
            Text(coupon ? "COUPON" : "Give Feedback",
                style: AppTheme.button.copyWith(
                    height: 1.toAutoScaledHeight,
                    fontSize: 11.toAutoScaledFont,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.black11))
          ],
        ),
      ),
    );
  }
}

void showCouponDialog(String text, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(child: CouponDialogBox(text: text));
      });
}

class CouponDialogBox extends StatelessWidget {
  const CouponDialogBox({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 310.toAutoScaledWidth,
        height: 83.toAutoScaledHeight,
        decoration: ShapeDecoration(
          color: Colors.amber,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.toAutoScaledWidth)),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.toAutoScaledWidth),
              child: Center(
                  child: Text(text,
                      style: AppTheme.headline3.copyWith(
                          fontSize: 17.toAutoScaledFont,
                          fontWeight: FontWeight.w400))),
            ),
            Positioned(
                right: 0,
                child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close)))
          ],
        ),
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
    return ShadowContainer(
      offset: 2,
      width: 312.toAutoScaledWidth,
      height: 168.toAutoScaledHeight,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 125.toAutoScaledWidth,
              height: 168.toAutoScaledHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: svg.Svg(
                    'assets/images/meal_card/${meal.title}.svg',
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 15.toAutoScaledHeight),
                  Container(
                    height: 28.toAutoScaledHeight,
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      meal.title,
                      style: AppTheme.headline1.copyWith(
                          fontSize: 20.toAutoScaledFont,
                          color: AppTheme.black11),
                    ),
                  ),
                  Container(
                    height: 17.toAutoScaledHeight,
                    padding: EdgeInsets.only(left: 12.toAutoScaledWidth),
                    child: Text(
                      '${DateFormat.jm().format(meal.startTime)} - ${DateFormat.jm().format(meal.endTime)}',
                      style: AppTheme.headline3.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.toAutoScaledFont,
                          color: AppTheme.grey2f),
                    ),
                  ),
                  SizedBox(height: 9.toAutoScaledHeight),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 12.toAutoScaledWidth),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: FSwitch(
                            enable: !meal.isLeaveToggleOutdated,
                            open: meal.leaveStatus.status != LeaveStatusEnum.A,
                            sliderColor: AppTheme.customWhite,
                            openColor: AppTheme.black2e,
                            height: 20.toAutoScaledHeight,
                            width: 44.toAutoScaledWidth,
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
                    ],
                  ),
                  SizedBox(height: 45.toAutoScaledHeight),
                  ...[
                    meal.isOutdated
                        ? GestureDetector(
                            onTap: () {
                              //TODO: lead to feedback page
                            },
                            child: const FeedbackAndCouponWidget(
                                taken: false, coupon: false),
                          )
                        : (_isMealValidForCoupon(meal)
                            ? GestureDetector(
                                onTap: () {
                                  if (!meal.isCouponOutdated) {
                                    context
                                        .read<YourMealDailyCardsCombinedBloc>()
                                        .add(ToggleMealCouponEvent(
                                            couponId:
                                                meal.couponStatus.status ==
                                                        CouponStatusEnum.A
                                                    ? meal.couponStatus.id!
                                                    : -1,
                                            couponAppliedAlready:
                                                meal.couponStatus.status ==
                                                    CouponStatusEnum.A,
                                            mealId: meal.id));
                                  } else if (meal.couponStatus.status ==
                                      CouponStatusEnum.A) {
                                    showCouponDialog(
                                        "Coupon no: ${meal.couponStatus.id!}",
                                        context);
                                  } else {
                                    showCouponDialog(
                                        "You can not apply for coupon now",
                                        context);
                                  }
                                },
                                child: FeedbackAndCouponWidget(
                                    taken: meal.couponStatus.status ==
                                        CouponStatusEnum.A,
                                    coupon: true),
                              )
                            : const SizedBox.shrink()),
                  ],
                  SizedBox(height: 10.toAutoScaledHeight)
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 18.toAutoScaledHeight),
                for (var item in meal.items) Text("  \u2022 ${item.name}"),
                const Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 22.toAutoScaledWidth,
                  ),
                  height: 0.5,
                  width: 145,
                  color: AppTheme.rulerColor,
                ),
                SizedBox(height: 8.toAutoScaledHeight),
                Container(
                  width: 187.toAutoScaledWidth,
                  padding: EdgeInsets.only(
                    left: 12.toAutoScaledWidth,
                    right: 19.toAutoScaledWidth,
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Daily Items: ',
                      style: AppTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFB51111)),
                      children: [
                        TextSpan(
                            text: dailyItemsParsed, style: AppTheme.bodyText2)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 17.toAutoScaledHeight)
              ],
            )
          ],
        ),
      ),
    );
  }
}

// TODO(nano): temp fix for the getters
extension on Meal {
  bool get isOutdated => false;
  bool get isLeaveToggleOutdated => false;
  bool get isCouponOutdated => false;
}
