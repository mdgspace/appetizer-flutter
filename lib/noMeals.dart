import 'package:flutter/material.dart';

class NoMealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                "The menu for this week is not available. Please contact your mess secretary"),
          ),
        ),
      ),
    );
  }
}
