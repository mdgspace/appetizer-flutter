import 'package:flutter/material.dart';
import 'colors.dart';

Widget getCustomProgressLoader(String message){
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height:80,
        width: 400,
        child: Card(
          shape: RoundedRectangleBorder(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
              ),
              Text(message, style: TextStyle(
                fontSize: 18,
              ),),
            ],
          ),
        ),
      ),
    ),
  );
}