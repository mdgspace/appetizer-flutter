import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/my_switches/see_switch_history.dart';
import 'package:appetizer/ui/my_switches/switch_status_card.dart';
import 'package:appetizer/viewmodels/switches/my_switches_viewmodel.dart';
import 'package:flutter/material.dart';

class MySwitches extends StatelessWidget {
  static const String id = 'my_switches_view';

  @override
  Widget build(BuildContext context) {
    return BaseView<MySwitchesViewModel>(
      onModelReady: (model) => model.getRemainingSwitches(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'My Switches',
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
                    SwitchStatusCard(model.switchCount),
                  ],
                ),
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SeeSwitchHistory(),
                      ],
                    ),
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
