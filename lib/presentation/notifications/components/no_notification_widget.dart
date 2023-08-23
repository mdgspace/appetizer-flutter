import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';

class NoNotificationsWidget extends StatelessWidget {
  const NoNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 282.toAutoScaledHeight),
      child: Text(
        'No new notifications !',
        style: TextStyle(
          color: Color(0xFF111111),
          fontSize: 18.toAutoScaledFont,
          fontFamily: 'Noto Sans',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
