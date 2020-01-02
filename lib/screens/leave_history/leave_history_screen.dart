import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appetizer/provider/year_and_month.dart';
import 'leave_dropdown_filter.dart';
import 'leave_timeline.dart';

class MyLeavesHistory extends StatelessWidget {
  final String token;

  const MyLeavesHistory({Key key, this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => YearAndMonthModel(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: const Color.fromRGBO(255, 193, 7, 1),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(
            "Leave History",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
        ),
        body: SafeArea(
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(),
                Positioned(
                  top: 0.0,
                  bottom: 0.0,
                  left: 0.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromRGBO(241, 241, 241, 1),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  bottom: 0.0,
                  left: 79,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: 1.0,
                    color: const Color.fromRGBO(0, 0, 0, 0.20),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  child: LeaveDropdownFilter(),
                ),
                Positioned(
                  top: 147.0,
                  left: 0.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 594.0,
                          ),
                          child: LeaveTimeline(
                            token: token,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
