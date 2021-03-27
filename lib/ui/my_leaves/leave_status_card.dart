import 'package:appetizer/globals.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/my_leaves/info_message.dart';
import 'package:appetizer/viewmodels/leaves/leave_status_card_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/colors.dart';

class LeaveStatusCard extends StatefulWidget {
  final int remainingLeaves;

  LeaveStatusCard(this.remainingLeaves);

  @override
  _LeaveStatusCardState createState() => _LeaveStatusCardState();
}

class _LeaveStatusCardState extends State<LeaveStatusCard> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LeaveStatusCardViewModel>(
      builder: (context, model, child) => Globals.isCheckedOut != null
          ? Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15.0, 16.0, 0.0, 0.0),
                                      child: Text(
                                        'Your Status',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromRGBO(
                                              00, 00, 00, 1),
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
                                            color: const Color.fromRGBO(
                                                79, 79, 79, 1),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        widget.remainingLeaves == null
                                            ? '-'
                                            : '${widget.remainingLeaves}',
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
                                          color: const Color.fromRGBO(
                                              79, 79, 79, 1),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      (Globals.isCheckedOut)
                                          ? 'CHECKED-OUT'
                                          : 'CHECKED-IN',
                                      style: TextStyle(
                                        color: (Globals.isCheckedOut)
                                            ? const Color.fromRGBO(
                                                235, 87, 87, 1)
                                            : const Color.fromRGBO(
                                                34, 139, 34, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 90,
                                    color: appiBrown,
                                  ),
                                ),
                              ),
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
                              color: (Globals.isCheckedOut)
                                  ? const Color.fromRGBO(34, 139, 34, 1)
                                  : const Color.fromRGBO(235, 87, 87, 1),
                              onPressed: model.onCheckTapped,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  (Globals.isCheckedOut)
                                      ? 'CHECK IN'
                                      : 'CHECK OUT',
                                  style: TextStyle(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 8,
                  child: (Globals.isCheckedOut)
                      ? InfoMessage('Check-in to start taking meals again')
                      : InfoMessage(
                          'Check-out to leave upcoming meals in sequence'),
                )
              ],
            )
          : Container(
              height: 180,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
                ),
              ),
            ),
    );
  }
}
