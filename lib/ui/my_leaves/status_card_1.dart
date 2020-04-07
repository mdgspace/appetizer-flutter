import 'package:flutter/material.dart';

class StatusCard1 extends StatelessWidget {
  final int _remainingLeaves;
  final bool _checkedIn;

  StatusCard1(this._remainingLeaves, this._checkedIn);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        elevation: 2.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom:
                      BorderSide(color: const Color.fromRGBO(00, 00, 00, 0.14)),
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                          child: Text(
                            'Your Status',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: const Color.fromRGBO(00, 00, 00, 1),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 6.0, 0.0, 2.0),
                              child: Text('Remaining leaves: ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color:
                                        const Color.fromRGBO(00, 00, 00, 0.54),
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 6.0, 8.0, 2.0),
                              child: Text(
                                '$_remainingLeaves',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: const Color.fromRGBO(255, 193, 7, 1),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(8.0, 2.0, 0.0, 8.0),
                              child: Text('Currently: ',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color:
                                        const Color.fromRGBO(00, 00, 00, 0.54),
                                  )),
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 2.0, 8.0, 8.0),
                                child: Text(
                                  (_checkedIn) ? 'CHECKED-IN' : 'CHECKED-OUT',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: const Color.fromRGBO(39, 174, 96, 1),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                  //TODO: ADD SVG FILE
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                elevation: 0.0,
                color: const Color.fromRGBO(235, 87, 87, 1),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Text(
                    (_checkedIn) ? 'CHECK OUT' : 'CHECK IN',
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
                onPressed: () => {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
