import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  const BlackButton({
    required this.title,
    required this.onTap,
    required this.width,
    Key? key,
  }) : super(key: key);

  final Function() onTap;
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
            color: Color(0xFFF6F6F6),
            fontSize: 12.toAutoScaledFont,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
            height: 1.50.toAutoScaledHeight,
          ),
        ),
      ),
    );
  }
}
