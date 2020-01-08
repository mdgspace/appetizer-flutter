import 'package:flutter/material.dart';

class ConfirmedSwitchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(128, 216, 34, 1),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/meals_switched.png",
              width: 150,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                "Switched Meals Successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontFamily: 'Lobster_Two'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
