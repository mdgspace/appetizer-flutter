import 'package:flutter/material.dart';

class SingleLeaveDetails extends StatelessWidget {
  final String _meal;
  final String _day;
  final int _date;

  SingleLeaveDetails(this._meal, this._day, this._date);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.0,
      width: 320.0,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: const Color.fromRGBO(0, 0, 0, 0.37),
          ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$_meal',
              style: TextStyle(
                fontSize: 16.0,
                color: const Color.fromRGBO(0, 0, 0, 0.87),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 16.0, 0.0),
                child: Text(
                  '$_day',
                  style: TextStyle(
                    color: const Color.fromRGBO(0, 0, 0, 0.67),
                    fontSize: 12.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 8.0),
                child: Text(
                  '$_date',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: const Color.fromRGBO(0, 0, 0, 0.67),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
