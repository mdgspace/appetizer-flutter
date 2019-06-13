import 'package:flutter/material.dart';

class MultipleLeaveDetails extends StatelessWidget{

  final String _mealFrom;
  final String _mealTo;
  final String _dayFrom;
  final String _dayTo;
  final int _dateFrom;
  final int _dateTo;

  MultipleLeaveDetails(
      this._mealFrom, this._mealTo,
      this._dayFrom, this._dayTo,
      this._dateFrom, this._dateTo
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156.0,
      width: 334.0,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                color: const Color.fromRGBO(0, 0, 0, 0.37),
              )
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$_mealTo',
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
                      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 16.0, 0.0),
                      child: Text(
                        '$_dayTo',
                        style: TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 0.67),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 8.0),
                      child: Text(
                        '$_dateTo',
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
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                  child: Text(
                    '$_mealFrom',
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
                        '$_dayFrom',
                        style: TextStyle(
                          color: const Color.fromRGBO(0, 0, 0, 0.67),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 16.0, 8.0),
                      child: Text(
                        '$_dateFrom',
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
          ),
        ],
      ),
    );
  }
}
