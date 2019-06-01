import 'package:flutter/material.dart';

import 'monthly_balance.dart';
import 'see_rebate_history.dart';

class MyRebates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          color: const Color.fromRGBO(255, 193, 7, 1),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text("My Rebates"),
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //TODO: ENTER CORRECT VALUES FOR MONTHLY BALANCE
          MonthlyBalance(1800, 403, 0, 'April', 2019),
          SeeRebateHistory()
        ],
      ),
    );
  }
}
