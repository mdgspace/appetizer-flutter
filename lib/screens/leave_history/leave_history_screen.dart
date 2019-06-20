import 'package:flutter/material.dart';

import 'leave_dropdown_filter.dart';
import 'leave_timeline.dart';

class MyLeavesHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          color: const Color.fromRGBO(255, 193, 7, 1),
          onPressed:() => Navigator.pop(context, false),
        ),
        title: Text("Leave History",
        style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
      ),
      body: Container(
        height: 734.0,
        width: 412.0,
        child: Stack(
          children: <Widget>[
            Container(),
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 0.0,
              child: Container(
                height: 734.0,
                width: 78.0,
                color: const Color.fromRGBO(241, 241, 241, 1),
              ),
            ),
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 79.0,
              child: Container(
                height: 734.0,
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
              top: 141.0,
              left: 0.0,
              child: Container(
                height: 594.0,
                width: 412.0,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 594.0,
                      ),
                      child: LeaveTimeline()
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
