import 'package:flutter/material.dart';
import 'package:appetizer/screens/leave_history/leave_history_screen.dart';

class SeeLeavesHistory extends StatelessWidget {
  final String token;

  const SeeLeavesHistory({Key key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                color: const Color.fromRGBO(00, 00, 00, 0.15),
              ),
              bottom: BorderSide(
                color: const Color.fromRGBO(00, 00, 00, 0.15),
              ))),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                child: Text(
                  'See Leave History',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyLeavesHistory(
                                token: token,
                              )));
                },
                iconSize: 40.0,
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyLeavesHistory(
                          token: token,
                        )));
          },
        ),
      ),
    );
  }
}
