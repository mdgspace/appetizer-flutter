import 'package:flutter/material.dart';

class SettingsPageFooter extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 38.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Made with ",
              style: TextStyle(
                color: const Color.fromRGBO(130, 130, 130, 0.9),
                fontSize: 16.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
              child: Icon(
                Icons.favorite,
                color: const Color.fromRGBO(242, 89, 89, 1),
              ),
            ),
            Text(
              " by MDG",
              style: TextStyle(
                color: const Color.fromRGBO(130, 130, 130, 0.9),
                fontSize: 16.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
