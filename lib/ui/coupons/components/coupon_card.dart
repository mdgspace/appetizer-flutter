import 'package:appetizer_revamp_parts/models/coupon/coupon.dart';
import 'package:flutter/material.dart';

class CouponCard extends StatelessWidget {
  const CouponCard({
    required this.coupon,
    Key? key,
  }) : super(key: key);

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 129,
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            width: 28,
            height: 61,
            child: Image.asset('lib/assets/images/coupon.png'),
          ),
          Container(
            width: 101,
            height: 61,
            padding: const EdgeInsets.only(
              top: 12,
              left: 8,
              right: 10,
              bottom: 12,
            ),
            decoration: const ShapeDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coupon.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 12,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  coupon.meal,
                  style: const TextStyle(
                    color: Color(0xFF2E2E2E),
                    fontSize: 10,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
