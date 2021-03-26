import 'package:flutter/material.dart';

class ManageLeaveBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color.fromRGBO(00, 00, 00, 0.54),
            offset: Offset(0.0, 4.0),
            blurRadius: 5.0,
          ),
        ],
        color: const Color.fromRGBO(121, 85, 72, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 2.0),
                  child: Text(
                    'Manage Your Leaves',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 2.0, 0.0, 8.0),
                  child: Text(
                    'See upcoming meals you are leaving',
                    style: TextStyle(
                        color: const Color.fromRGBO(255, 193, 7, 1),
                        fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
