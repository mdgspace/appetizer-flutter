import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({
    super.key,
    required this.child,
    required this.height,
    required this.width,
    required this.offset,
    // required this.padding
  });
  final double height, width, offset;
  // final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      // padding: padding,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: [
          BoxShadow(
            color: AppTheme.shadowColor,
            blurRadius: 12,
            offset: Offset(offset, offset),
            spreadRadius: 1,
          )
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
