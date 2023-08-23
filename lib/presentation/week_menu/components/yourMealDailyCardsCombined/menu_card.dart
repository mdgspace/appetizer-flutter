import 'package:appetizer/app_theme.dart';
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
        height: 24,
        width: 88,
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    height: 1,
                    fontSize: 11,
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
        width: 310,
        height: 83,
        decoration: ShapeDecoration(
          color: Colors.amber,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Center(
                  child: Text(text,
                      style: AppTheme.headline3.copyWith(
                          fontSize: 17, fontWeight: FontWeight.w400))),
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
      width: 312,
      height: 168,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 125,
              height: 168,
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
                  const SizedBox(height: 15),
                  Container(
                    height: 28,
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      meal.title,
                      style: AppTheme.headline1
                          .copyWith(fontSize: 20, color: AppTheme.black11),
                    ),
                  ),
                  Container(
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
                  const SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 12),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: FSwitch(
                            enable: !meal.isLeaveToggleOutdated,
                            open: meal.leaveStatus.status != LeaveStatusEnum.A,
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
                    ],
                  ),
                  const SizedBox(height: 45),
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
                  const SizedBox(height: 10)
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18),
                for (var item in meal.items) Text("  \u2022 ${item.name}"),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.fromLTRB(22, 0, 20, 0),
                  height: 0.5,
                  width: 145,
                  color: AppTheme.rulerColor,
                ),
                const SizedBox(height: 8),
                Container(
                  width: 187,
                  padding:
                      const EdgeInsets.only(left: 12, right: 19, bottom: 0),
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
                const SizedBox(height: 17)
              ],
            )
          ],
        ),
      ),
    );
  }
}
