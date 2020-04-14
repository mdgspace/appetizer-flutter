import 'package:appetizer/constants.dart';
import 'package:flutter/material.dart';

class AppiErrorWidget extends StatelessWidget {
  final String message;

  const AppiErrorWidget({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Center(
              child: Text(message ?? Constants.GENERIC_FAILURE),
            ),
          ),
        )
      ],
    );
  }
}
