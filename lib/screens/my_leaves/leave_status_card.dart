import 'package:appetizer/services/leave.dart';
import 'package:flutter/material.dart';
import '../../login.dart';
import 'package:appetizer/services/user.dart';
import 'package:appetizer/colors.dart';

class LeaveStatusCard extends StatefulWidget {
  final int _remainingLeaves;

  LeaveStatusCard(this._remainingLeaves);

  @override
  _LeaveStatusCardState createState() => _LeaveStatusCardState();
}

class _LeaveStatusCardState extends State<LeaveStatusCard> {
  bool _isCheckedIn;

  @override
  void initState() {
    getUserDetails().then((userDetails) {
      userMeGet(userDetails.getString("token")).then((myDetails) {
        setState(() {
          _isCheckedIn = !myDetails.isCheckedOut;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckedIn != null) {
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
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
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
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 2.0, 8.0, 8.0),
                          child: Text(
                            (_isCheckedIn) ? 'CHECKED-IN' : 'CHECKED-OUT',
                            style: TextStyle(
                              color: (!_isCheckedIn)
                                  ? const Color.fromRGBO(235, 87, 87, 1)
                                  : const Color.fromRGBO(34, 139, 34, 1),
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      color: (_isCheckedIn)
                          ? const Color.fromRGBO(235, 87, 87, 1)
                          : const Color.fromRGBO(34, 139, 34, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          (_isCheckedIn) ? 'CHECK OUT' : 'CHECK IN',
                          style: TextStyle(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                      onPressed: onCheckTapped,
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
                        '${widget._remainingLeaves}',
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
    return Container(
      height: 155,
      child: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(appiYellow)),
      ),
    );
  }

  void onCheckTapped() {
    getUserDetails().then((userDetails) {
      userMeGet(userDetails.getString("token")).then((myDetails) {
        if (!myDetails.isCheckedOut) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Check Out"),
                  content: Text("Are you sure you would like to Check-Out?"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(fontSize: 15, color: appiYellow),
                        )),
                    FlatButton(
                        onPressed: () {
                          check(userDetails.getString("token"))
                              .then((checkInfo) {
                            if (checkInfo.isCheckedOut) {
                              setState(() {
                                _isCheckedIn = false;
                              });
                            } else {
                              setState(() {
                                _isCheckedIn = true;
                              });
                            }
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          "CHECK OUT",
                          style: TextStyle(fontSize: 15, color: appiYellow),
                        )),
                  ],
                ),
          );
        } else {
          check(userDetails.getString("token")).then((checkInfo) {
            if (checkInfo.isCheckedOut) {
              setState(() {
                _isCheckedIn = false;
              });
            } else {
              setState(() {
                _isCheckedIn = true;
              });
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("You have checked in")));
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
