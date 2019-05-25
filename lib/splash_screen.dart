import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlareActor(
          "flare_files/SplashScreen 2.0 (1).flr",
          fit: BoxFit.fill,
          animation: "SplashScreen 2.0",
        )
    );
  }
}
