import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/my_switches/see_switch_history.dart';
import 'package:appetizer/ui/my_switches/switch_status_card.dart';
import 'package:appetizer/viewmodels/switch_models/my_switches_model.dart';
import 'package:flutter/material.dart';

class MySwitches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MySwitchesModel>(
      onModelReady: (model) => model.getRemainingSwitches(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: const Color.fromRGBO(255, 193, 7, 1),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(
            "My Switches",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SwitchStatusCard(model.switchCount?.count),
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
