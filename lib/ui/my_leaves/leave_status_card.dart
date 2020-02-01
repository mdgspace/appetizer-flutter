import 'package:appetizer/globals.dart';
import 'package:appetizer/ui/my_leaves/info_message.dart';
import 'package:appetizer/services/leave.dart';
import 'package:appetizer/utils/user_details.dart';
import 'package:flutter/material.dart';
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
  String imageUrl;

  @override
  void initState() {
    UserDetailsUtils.getUserDetails().then((userDetails) {
      userMeGet(userDetails.getString("token")).then((myDetails) {
        setState(() {
          _isCheckedIn = !myDetails.isCheckedOut;
          imageUrl = myDetails.imageUrl;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckedIn != null) {
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 5.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 16.0, 0.0, 0.0),
                                child: Text(
                                  'Your Status',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromRGBO(00, 00, 00, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      15.0, 4.0, 4.0, 4.0),
                                  child: Text(
                                    'Remaining Leaves : ',
                                    style: TextStyle(
                                      color:
                                          const Color.fromRGBO(79, 79, 79, 1),
                                    ),
                                  ),
                                ),
                                Text(
                                  widget._remainingLeaves == null
                                      ? '-'
                                      : '${widget._remainingLeaves}',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    15.0, 4.0, 4.0, 4.0),
                                child: Text(
                                  'Currently : ',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(79, 79, 79, 1),
                                  ),
                                ),
                              ),
                              Text(
                                (_isCheckedIn) ? 'CHECKED-IN' : 'CHECKED-OUT',
                                style: TextStyle(
                                  color: (!_isCheckedIn)
                                      ? const Color.fromRGBO(235, 87, 87, 1)
                                      : const Color.fromRGBO(34, 139, 34, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Container(
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Icon(
                                Icons.account_circle,
                                size: 90,
                                color: appiBrown,
                              ),
                            )),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Container(color: Colors.grey, height: 0.5),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
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
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 8,
            child: (_isCheckedIn)
                ? InfoMessage("Check-out to leave upcoming meals in sequence")
                : InfoMessage("Check-in to start taking meals again"),
          )
        ],
      );
    }
    return Container(
      height: 180,
      child: Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(appiYellow)),
      ),
    );
  }

  void onCheckTapped() {
    UserDetailsUtils.getUserDetails().then((userDetails) {
      userMeGet(userDetails.getString("token")).then((myDetails) {
        if (!myDetails.isCheckedOut) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(
                "Check Out",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text("Are you sure you would like to Check-Out?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                          color: appiYellow, fontWeight: FontWeight.bold),
                    )),
                FlatButton(
                    onPressed: () {
                      check(userDetails.getString("token")).then((checkInfo) {
                        if (checkInfo.isCheckedOut) {
                          setState(() {
                            isCheckedOut = true;
                            _isCheckedIn = false;
                          });
                        } else {
                          setState(() {
                            isCheckedOut = false;
                            _isCheckedIn = true;
                          });
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      "CHECK OUT",
                      style: TextStyle(
                          color: appiYellow, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          );
        } else {
          check(userDetails.getString("token")).then((checkInfo) {
            if (checkInfo.isCheckedOut) {
              setState(() {
                isCheckedOut = true;
                _isCheckedIn = false;
              });
            } else {
              setState(() {
                isCheckedOut = false;
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
