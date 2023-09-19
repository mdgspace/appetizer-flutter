import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({super.key, required this.height, required this.child});
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height + 12.toAutoScaledHeight,
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: Svg('assets/images/banner.svg'), //path of image
            fit: BoxFit.fitWidth,
          )),
          child: SafeArea(
            child: Padding(
              padding: 20.toVerticalPadding,
              child: child,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -12.toAutoScaledHeight),
          child: Container(
            height: 12.toAutoScaledHeight,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.toAutoScaledWidth),
                  topRight: Radius.circular(12.toAutoScaledWidth),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
