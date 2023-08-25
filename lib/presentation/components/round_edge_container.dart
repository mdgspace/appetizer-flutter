// Wrap this widget in a GestureDetector and you are good to go!

import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';

class RoundEdgeContainers extends StatelessWidget {
  const RoundEdgeContainers({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34.toAutoScaledHeight,
      padding: EdgeInsets.symmetric(
          horizontal: 25.toAutoScaledWidth, vertical: 8.toAutoScaledHeight),
      decoration: ShapeDecoration(
        color: AppTheme.black11,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.toAutoScaledWidth)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

class RoundEdgeTextOnlyContainer extends StatelessWidget {
  const RoundEdgeTextOnlyContainer({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return RoundEdgeContainers(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.toAutoScaledWidth),
          child: Text(
            text,
            style: AppTheme.button,
          ),
        ),
      ],
    );
  }
}
