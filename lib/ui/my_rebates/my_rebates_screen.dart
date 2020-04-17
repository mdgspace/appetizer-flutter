import 'package:appetizer/colors.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/error_widget.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/rebates_models/my_rebates_model.dart';
import 'package:flutter/material.dart';

import 'monthly_balance.dart';
import 'see_rebate_history.dart';

class MyRebates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MyRebatesModel>(
      onModelReady: (model) => model.getMonthlyRebate(),
      builder: (context, model, child) => Scaffold(
        key: myRebatesViewScaffoldKey,
        appBar: AppBar(
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
              model.state == ViewState.Busy
                  ? Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 200),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(appiYellow),
                          ),
                        ),
                      ),
                    )
                  : model.state == ViewState.Error
                      ? AppiErrorWidget(message: model.errorMessage)
                      : MonthlyBalance(
                          0,
                          model.monthlyRebate.rebate,
                          0,
                          DateTimeUtils.getMonthName(DateTime.now()),
                          DateTime.now().year),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                child: SeeRebateHistory(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
