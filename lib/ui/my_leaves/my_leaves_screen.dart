import 'package:appetizer/globals.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/leaves_models/my_leaves_model.dart';
import 'package:flutter/material.dart';

import 'leave_status_card.dart';
import 'see_leave_history.dart';

class MyLeaves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MyLeavesModel>(
      onModelReady: (model) => model.getRemainingLeaves(),
      builder: (context, model, child) => Scaffold(
        key: myLeavesViewScaffoldKey,
        appBar: AppBar(
          title: Text(
            'My Leaves',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    LeaveStatusCard(model.leaveCount?.count),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SeeLeavesHistory(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
