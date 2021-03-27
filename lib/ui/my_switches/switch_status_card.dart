import 'package:appetizer/colors.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/switches/switch_status_card_viewmodel.dart';
import 'package:flutter/material.dart';

class SwitchStatusCard extends StatefulWidget {
  final int remainingSwitches;

  SwitchStatusCard(this.remainingSwitches);

  @override
  _SwitchStatusCardState createState() => _SwitchStatusCardState();
}

class _SwitchStatusCardState extends State<SwitchStatusCard> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SwitchStatusCardViewModel>(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                        ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15.0, 4.0, 4.0, 4.0),
                                          child: Text(
                                            'Remaining Switches : ',
                                            style: TextStyle(
                                              color: const Color.fromRGBO(
                                                  79, 79, 79, 1),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          widget.remainingSwitches == null
                                              ? '-'
                                              : '${widget.remainingSwitches}',
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
                                    child: Icon(
                                      Icons.account_circle,
                                      size: 90,
                                      color: appiBrown,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
