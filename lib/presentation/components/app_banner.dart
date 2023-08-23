import 'package:flutter/material.dart';

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
          image: AssetImage("assets/images/banner.png"), //path of image
          fit: BoxFit.cover,
        )),
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
