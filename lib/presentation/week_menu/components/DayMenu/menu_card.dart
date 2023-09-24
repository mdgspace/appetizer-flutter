import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/router/intrinsic_router/intrinsic_router.gr.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/menu/week_menu_tmp.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/presentation/week_menu/bloc/week_menu_bloc.dart';
import 'package:appetizer/presentation/components/shadow_container.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:fswitch_nullsafety/fswitch_nullsafety.dart';
import 'package:intl/intl.dart';
import 'dart:math';

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
        child: Center(
          child: Text(
            coupon ? "COUPON ${taken ? 'TAKEN' : ''}" : "Give Feedback",
            textAlign: TextAlign.center,
            style: AppTheme.button.copyWith(
              height: 1.toAutoScaledHeight,
              fontSize: 11.toAutoScaledFont,
              fontWeight: FontWeight.w600,
              color: AppTheme.black11,
            ),
          ),
        ),
        // child: Row(
        //   mainAxisAlignment: (coupon && taken)
        //       ? MainAxisAlignment.spaceBetween
        //       : MainAxisAlignment.center,
        //   children: [
        //     if (coupon && taken) ...[
        //       SvgPicture.asset('assets/icons/coupon_taken_tick.svg')
        //     ],
        //     Text(
        //       coupon ? "COUPON" : "Give Feedback",
        //       textAlign: TextAlign.center,
        //       style: AppTheme.button.copyWith(
        //         height: 1.toAutoScaledHeight,
        //         fontSize: 11.toAutoScaledFont,
        //         fontWeight: FontWeight.w600,
        //         color: AppTheme.black11,
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

void showCouponDialog(String text, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CouponDialogBox(text: text);
    },
  );
}

class CouponDialogBox extends StatelessWidget {
  const CouponDialogBox({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.toAutoScaledWidth),
      ),
      backgroundColor: const Color(0xFFFFCB74),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: context.router.pop,
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: Icon(Icons.close),
              ),
            ),
          ),
          Text(
            text,
            style: AppTheme.headline3.copyWith(
              fontSize: 17.toAutoScaledFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          20.toVerticalSizedBox,
        ],
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  const MealCard({
    required this.meal,
    required this.dailyItems,
    super.key,
  });
  final Meal meal;
  final List<MealItem> dailyItems;

  @override
  Widget build(BuildContext context) {
    String dailyItemsParsed = '';
    for (MealItem item in dailyItems) {
      dailyItemsParsed += '${item.name}, ';
    }
    dailyItemsParsed =
        dailyItemsParsed.substring(0, max(dailyItemsParsed.length - 2, 0));
    return ShadowContainer(
      offset: 2,
      width: 315.toAutoScaledWidth,
      height: 170.toAutoScaledHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 125.toAutoScaledWidth,
            height: 170.toAutoScaledHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: svg.Svg(
                  'assets/images/meal_card/${meal.title}.svg',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                15.toVerticalSizedBox,
                Container(
                  height: 28.toAutoScaledHeight,
                  padding: 12.toLeftOnlyPadding,
                  child: Text(
                    meal.title,
                    style: AppTheme.headline1.copyWith(
                      fontSize: 20.toAutoScaledFont,
                      color: AppTheme.black11,
                    ),
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
                      color: AppTheme.grey2f,
                    ),
                  ),
                ),
                10.toVerticalSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 12.toAutoScaledWidth),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: BlocSelector<AppBloc, AppState, bool>(
                          selector: (state) => state.user!.isCheckedOut,
                          builder: (context, isCheckout) {
                            return FSwitch(
                              enable:
                                  !meal.isLeaveToggleOutdated && !isCheckout,
                              open:
                                  meal.leaveStatus.status != LeaveStatusEnum.P,
                              sliderColor: AppTheme.customWhite,
                              openColor: AppTheme.black2e,
                              height: 20.toAutoScaledHeight,
                              width: 44.toAutoScaledWidth,
                              onChanged: (value) async {
                                context
                                    .read<WeekMenuBlocBloc>()
                                    .add(MealLeaveEvent(
                                      meal: meal,
                                    ));
                              },
                            );
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
                            context.router.navigate(FeedbackRoute());
                          },
                          child: const FeedbackAndCouponWidget(
                              taken: false, coupon: false),
                        )
                      : (_isMealValidForCoupon(meal)
                          ? GestureDetector(
                              onLongPress: () {
                                if (meal.couponStatus.status ==
                                    CouponStatusEnum.A) {
                                  // TODO: show dialog box
                                }
                              },
                              onTap: () {
                                if (!meal.isCouponOutdated) {
                                  // TODO: show dialog box and then add toggle event
                                  context
                                      .read<WeekMenuBlocBloc>()
                                      .add(MealCouponEvent(
                                        coupon: meal.couponStatus,
                                        mealId: meal.id,
                                      ));
                                } else if (meal.couponStatus.status ==
                                    CouponStatusEnum.A) {
                                  showCouponDialog(
                                    "Coupon no: ${meal.couponStatus.id!}",
                                    context,
                                  );
                                }
                              },
                              child: FeedbackAndCouponWidget(
                                taken: meal.couponStatus.status ==
                                    CouponStatusEnum.A,
                                coupon: true,
                              ),
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
              Container(
                constraints: BoxConstraints.tightFor(
                  height: 100.toAutoScaledWidth,
                  width: 180.toAutoScaledWidth,
                ),
                padding: EdgeInsets.only(left: 10.toAutoScaledWidth),
                child: ListView.builder(
                  itemCount: meal.items.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final item = meal.items[index];
                    return Text("\u2022 ${item.name}");
                  },
                ),
              ),
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
    );
  }
}

// TODO(nano): temp fix for the getters
// extension on Meal {
//   bool get isOutdated => false;
//   bool get isLeaveToggleOutdated => false;
//   bool get isCouponOutdated => false;
// }
