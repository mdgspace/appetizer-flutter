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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;
import 'package:fswitch_nullsafety/fswitch_nullsafety.dart';
import 'package:intl/intl.dart';
import 'package:appetizer/utils/recase.dart';
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
    return Container(
      height: 24.toAutoScaledHeight,
      constraints: BoxConstraints(minWidth: 90.toAutoScaledWidth),
      padding: EdgeInsets.symmetric(horizontal: 8.toAutoScaledWidth),
      decoration: ShapeDecoration(
        color: AppTheme.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (coupon && taken) ...[
            SvgPicture.asset('assets/icons/coupon_taken_tick.svg'),
            4.toHorizontalSizedBox,
          ],
          Text(
            coupon ? "COUPON" : "Give Feedback",
            textAlign: TextAlign.center,
            style: AppTheme.button.copyWith(
              fontSize: 11.toAutoScaledFont,
              fontWeight: FontWeight.w600,
              color: AppTheme.black11,
            ),
          ),
        ],
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
              onTap: context.router.maybePop,
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: Icon(Icons.close),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toAutoScaledWidth),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppTheme.headline3.copyWith(
                fontSize: 17.toAutoScaledFont,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          20.toVerticalSizedBox,
        ],
      ),
    );
  }
}

class FeedbackOrCouponButton extends StatelessWidget {
  const FeedbackOrCouponButton({
    required this.meal,
    super.key,
  });
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, bool>(
      selector: (state) => state.user!.isCheckedOut,
      builder: (context, isCheckout) {
        if (meal.isOutdated) {
          return GestureDetector(
            onTap: () {
              context.router.navigate(FeedbackRoute(mealId: meal.id));
            },
            child: const FeedbackAndCouponWidget(taken: false, coupon: false),
          );
        } else if (isCheckout || meal.leaveStatus.status == LeaveStatusEnum.P) {
          return const SizedBox.shrink();
        } else if (_isMealValidForCoupon(meal)) {
          return GestureDetector(
            onTap: () {
              if (meal.couponStatus.status == CouponStatusEnum.A) {
                showCouponDialog(
                  "Coupon no: ${meal.couponStatus.id!}",
                  context,
                );
              } else {
                context.read<WeekMenuBlocBloc>().add(MealCouponEvent(
                      coupon: meal.couponStatus,
                      mealId: meal.id,
                    ));
              }
            },
            child: FeedbackAndCouponWidget(
              taken: meal.couponStatus.status == CouponStatusEnum.A,
              coupon: true,
            ),
          );
        }
        return const SizedBox.shrink();
      },
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
      dailyItemsParsed += '${item.name.titleCase}, ';
    }
    dailyItemsParsed =
        dailyItemsParsed.substring(0, max(dailyItemsParsed.length - 2, 0));

    return ShadowContainer(
      offset: 2,
      width: 315.toAutoScaledWidth,
      height: 180.toAutoScaledHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 125.toAutoScaledWidth,
            height: 180.toAutoScaledHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: svg.Svg(
                  'assets/images/meal_card/${meal.title}.svg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.fromLTRB(
              10.toAutoScaledWidth,
              12.toAutoScaledHeight,
              8.toAutoScaledWidth,
              8.toAutoScaledHeight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.title.titleCase,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.headline1.copyWith(
                    fontSize: 18.toAutoScaledFont,
                    color: AppTheme.black11,
                  ),
                ),
                2.toVerticalSizedBox,
                Text(
                  '${DateFormat.jm().format(meal.startTime)} - ${DateFormat.jm().format(meal.endTime)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTheme.headline3.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 11.toAutoScaledFont,
                    color: AppTheme.grey2f,
                  ),
                ),
                8.toVerticalSizedBox,
                BlocSelector<AppBloc, AppState, bool>(
                  selector: (state) => state.user!.isCheckedOut,
                  builder: (context, isCheckout) {
                    return FSwitch(
                      enable: !meal.isLeaveToggleOutdated && !isCheckout,
                      open: meal.leaveStatus.status != LeaveStatusEnum.P,
                      sliderColor: AppTheme.customWhite,
                      openColor: AppTheme.black2e,
                      height: 20.toAutoScaledHeight,
                      width: 44.toAutoScaledWidth,
                      onChanged: (value) async {
                        context.read<WeekMenuBlocBloc>().add(MealLeaveEvent(
                              meal: meal,
                            ));
                      },
                    );
                  },
                ),
                const Spacer(),
                FeedbackOrCouponButton(meal: meal),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                10.toAutoScaledWidth,
                14.toAutoScaledHeight,
                12.toAutoScaledWidth,
                12.toAutoScaledHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: meal.items.length,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = meal.items[index];
                        return Text(
                          "\u2022 ${item.name.titleCase}",
                          style: AppTheme.bodyText2,
                        );
                      },
                    ),
                  ),
                  Divider(
                    height: 12.toAutoScaledHeight,
                    thickness: 0.5,
                    color: AppTheme.rulerColor,
                  ),
                  Text(
                    'Daily Items: $dailyItemsParsed',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFB51111),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
