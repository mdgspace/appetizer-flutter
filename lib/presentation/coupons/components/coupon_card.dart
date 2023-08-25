import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/coupon/coupon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    required this.coupon,
    Key? key,
  }) : super(key: key);

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return Row(
      //TODO: test if parent widget required or not
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          width: 28.toAutoScaledWidth,
          height: 61.toAutoScaledHeight,
          child: SvgPicture.asset('assets/images/coupon.svg'),
        ),
        Container(
          width: 101.toAutoScaledWidth,
          height: 61.toAutoScaledHeight,
          padding: EdgeInsets.only(
            top: 12.toAutoScaledHeight,
            left: 8.toAutoScaledWidth,
            right: 10.toAutoScaledWidth,
            bottom: 12.toAutoScaledHeight,
          ),
          decoration: ShapeDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.circular(12.toAutoScaledWidth),
                bottomLeft: Radius.zero,
                bottomRight: Radius.circular(12.toAutoScaledWidth),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                coupon.id.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color(0xFF111111),
                  fontSize: 12.toAutoScaledFont,
                  fontFamily: 'Noto Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.toAutoScaledHeight),
              Text(
                coupon.meal,
                style: TextStyle(
                  color: Color(0xFF2E2E2E),
                  fontSize: 10.toAutoScaledFont,
                  fontFamily: 'Noto Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
