import 'package:flutter/material.dart';

class NoMealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Image.asset("assets/images/no_menu_wrapper.jpeg"),
          ),
        ),
      ),
    );
  }
}
