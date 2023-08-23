import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({super.key, required this.height, required this.child});
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: height + 12,
        width: 360,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: Svg('assets/images/banner.svg'),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
      Positioned(
        bottom: 0,
        child: Container(
          height: 12,
          width: 360,
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
