// Wrap this widget in a GestureDetector and you are good to go!

import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class RoundEdgeContainers extends StatelessWidget {
  const RoundEdgeContainers({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      decoration: ShapeDecoration(
        color: AppTheme.black11,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Row(
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
        Text(
          text,
          style: AppTheme.button,
        ),
      ],
    );
  }
}
