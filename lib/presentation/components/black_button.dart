import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlackButton extends StatelessWidget {
  const BlackButton({
    required this.title,
    required this.onTap,
    required this.width,
    super.key,
  });

  final VoidCallback onTap;
  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.toAutoScaledHeight,
      width: width,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.toAutoScaledWidth),
        ),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFFF6F6F6),
            fontSize: 12.toAutoScaledFont,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class BlackIconButton extends StatelessWidget {
  const BlackIconButton({
    required this.title,
    required this.onTap,
    required this.width,
    required this.icon,
    super.key,
  });

  final VoidCallback onTap;
  final String title;
  final double width;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.toAutoScaledHeight,
      width: width,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: const Color(0xFFF6F6F6),
                fontSize: 12.toAutoScaledFont,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
              ),
            ),
            12.toVerticalSizedBox,
            Container(
              height: 14.toAutoScaledWidth,
              width: 14.toAutoScaledWidth,
              alignment: Alignment.centerRight,
              child: SvgPicture.asset('assets/images/icons/submit_icon.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
