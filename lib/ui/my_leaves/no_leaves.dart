import 'package:flutter/material.dart';

class NoLeaves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 4,
        ),
        Text(
          'You have no upcoming leaves',
          style: TextStyle(
            fontSize: 18.0,
            color: const Color.fromRGBO(0, 0, 0, 0.54),
          ),
        ),
      ],
    );
  }
}
