import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer(
      {super.key,
      required this.child,
      required this.height,
      required this.width});
  final double height, width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: AppTheme.shadowColor,
            blurRadius: 21.43,
            offset: Offset(0, 0),
            spreadRadius: 1.07,
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
