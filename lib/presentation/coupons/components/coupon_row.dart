import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/coupon/coupon.dart';
import 'package:appetizer/presentation/coupons/components/coupon_card.dart';
import 'package:flutter/material.dart';

class CouponRow extends StatelessWidget {
  const CouponRow({
    required this.coupons,
    Key? key,
  }) : super(key: key);

  final List<Coupon> coupons;

  @override
  Widget build(BuildContext context) {
    if (coupons.length == 2) {
      return SizedBox(
        height: 90.toAutoScaledHeight,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 68.toAutoScaledHeight,
            child: Row(
              children: [
                CouponCard(coupon: coupons.first),
                const Spacer(),
                CouponCard(coupon: coupons.last),
              ],
            ),
          ),
        ),
      );
    } else if (coupons.length == 1) {
      return SizedBox(
        height: 90.toAutoScaledHeight,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 68.toAutoScaledHeight,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CouponCard(coupon: coupons.first),
              ],
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
