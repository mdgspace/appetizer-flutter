import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/leaves/my_leaves_viewmodel.dart';
import 'package:flutter/material.dart';

import 'leave_status_card.dart';
import 'see_leave_history.dart';

class MyLeaves extends StatelessWidget {
  static const String id = 'my_leaves_view';

  @override
  Widget build(BuildContext context) {
    return BaseView<MyLeavesViewModel>(
      onModelReady: (model) => model.getRemainingLeaves(),
      builder: (context, model, child) => Scaffold(
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
                    LeaveStatusCard(model.leaveCount),
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
