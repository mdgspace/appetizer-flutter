import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({super.key, required this.height, required this.child});
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: 360,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/meal_card/Lunch.png"), //path of image
        fit: BoxFit.cover,
      )),
      child: child,
    );
  }
}
