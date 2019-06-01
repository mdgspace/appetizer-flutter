import 'package:flutter/material.dart';

class StatusCard2 extends StatelessWidget{

  final bool _checkedIn;
  final int _remainingLeaves;

  StatusCard2(this._remainingLeaves,this._checkedIn);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: const Color.fromRGBO(00, 00, 00, 0.15),
                    )
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0,8.0,0.0,0.0),
                      child: Text(
                        'Your Status',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: const Color.fromRGBO(00, 00, 00, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20.0,2.0,8.0,8.0),
                        child: Text(
                          (_checkedIn)? 'CHECKED-IN' : 'CHECKED-OUT',
                          style: TextStyle(
                            color: const Color.fromRGBO(39, 174, 96, 1),
                          ),
                        )
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RaisedButton(
                    color: const Color.fromRGBO(235, 87, 87, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        (_checkedIn)? 'CHECK OUT' : 'CHECK IN',
                        style: TextStyle(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    onPressed: ()=>{},
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 8.0, 8.0, 8.0),
                    child: Text(
                      'Remaining Semester Leaves',
                      style: TextStyle(
                        color: const Color.fromRGBO(79, 79, 79, 1),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 2.0, 0.0, 16.0),
                    child: Text(
                      '$_remainingLeaves',
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),

                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
