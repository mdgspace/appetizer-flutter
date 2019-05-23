import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlareActor(
          "Flare/SplashScreen.flr",
          fit: BoxFit.fill,
          animation: "SplashScreen",
        )
    );
  }
}
