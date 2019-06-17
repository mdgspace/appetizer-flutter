import 'package:flutter/material.dart';

import 'monthly_balance.dart';
import 'see_rebate_history.dart';
import 'package:appetizer/services/transaction.dart';
import 'package:appetizer/login.dart';
import 'package:appetizer/monthIntToMonthString.dart';

class MyRebates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color.fromRGBO(255, 193, 7, 1),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text(
          "My Rebates",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          //getMonthRebate(),
          MonthlyBalance(1800, 400, 0, "April", 2019),
          SeeRebateHistory()
        ],
      ),
    );
  }
}

MonthlyBalance getMonthRebate() {
  int currentMonthRebate;
  getUserDetails().then(
    (userDetails) {
      getMonthlyRebate(userDetails.getString("token")).then((monthlyRebate) {
        print(monthlyRebate.rebate);
        currentMonthRebate = monthlyRebate.rebate;
      });
    },
  );
  return MonthlyBalance(1800, currentMonthRebate, 0,
      monthIntToMonthString(DateTime.now().month), DateTime.now().year);
}
