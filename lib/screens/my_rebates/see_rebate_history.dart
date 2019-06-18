import 'package:flutter/material.dart';
import 'package:appetizer/screens/rebate_history/rebate_history_screen.dart';

class SeeRebateHistory extends StatelessWidget {
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
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                child: Text(
                  'See Rebate History',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right),
                iconSize: 40.0,
                onPressed: () {},
              ),
            ],
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RebateHistoryScreen()));
          },
        ),
      ),
    );
  }
}
