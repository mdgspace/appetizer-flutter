import 'package:appetizer/enums/meal_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class MealCardBase extends StatefulWidget {
  const MealCardBase({super.key, required this.mealType});
  final MealType mealType;

  @override
  State<MealCardBase> createState() => _MealCardBaseState();
}

class _MealCardBaseState extends State<MealCardBase> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      height: 168,
      width: 125,
      child: Row(
        children: [
          Container(
            color: const Color.fromARGB(1, 255, 203, 116),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Svg("assets/images/${widget.mealType.toString()}.svg"),
              ),
            ),
            width: 125,
            child: const Column(),
          ),
          const SizedBox(
            width: 187,
            child: Column(),
          )
        ],
      ),
    );
  }
}

// 2 buttons -> Give Feedback, Coupon
