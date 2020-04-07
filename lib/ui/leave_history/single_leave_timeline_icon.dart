import 'package:flutter/material.dart';

class SingleLeaveTimelineIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 12.0,
          width: 12.0,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 193, 7, 1),
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          top: 2.0,
          left: 2.0,
          child: Container(
            height: 8.0,
            width: 8.0,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 1),
              shape: BoxShape.circle,
            ),
          ),
        )
      ],
    );
  }
}
