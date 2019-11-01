import 'package:flutter/material.dart';

import '../../colors.dart';
import 'monthly_balance.dart';
import 'see_rebate_history.dart';
import 'package:appetizer/services/transaction.dart';
import 'package:appetizer/utils/month_int_to_month_string.dart';

class MyRebates extends StatelessWidget {
  final String token;

  const MyRebates({Key key, this.token}) : super(key: key);

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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            getMonthRebate(),
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              child: SeeRebateHistory(token: token),
            )
          ],
        ),
      ),
    );
  }

  Widget getMonthRebate() {
    return FutureBuilder(
        future: getMonthlyRebate(token),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(appiYellow),
                  ),
                ),
              ),
            );
          } else {
            return MonthlyBalance(
                0,
                snapshot.data.rebate,
                0,
                monthIntToMonthString(DateTime.now().month),
                DateTime.now().year);
          }
        });
  }
}
