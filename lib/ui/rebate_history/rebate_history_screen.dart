import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/error_widget.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/rebates_models/rebate_history_model.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/colors.dart';
import 'rebate_history_card.dart';

class RebateHistoryScreen extends StatefulWidget {
  @override
  _RebateHistoryScreenState createState() => _RebateHistoryScreenState();
}

class _RebateHistoryScreenState extends State<RebateHistoryScreen> {
  final _yearList = [
    DateTime.now().year,
    DateTime.now().year - 1,
    DateTime.now().year - 2,
    DateTime.now().year - 3,
    DateTime.now().year - 4,
  ];

  int currentItemSelected = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return BaseView<RebateHistoryModel>(
      onModelReady: (model) => model.getYearlyRebate(currentItemSelected),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Rebate History',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 150.0,
                child: getDropdownFilter(),
              ),
              Expanded(
                child: model.state == ViewState.Busy
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(appiYellow),
                          ),
                        ),
                      )
                    : model.state == ViewState.Error
                        ? AppiErrorWidget(message: model.errorMessage)
                        : ListView.builder(
                            itemCount: model.yearlyRebate.count,
                            itemBuilder: (BuildContext context, int index) {
                              return RebateHistoryCard(
                                  0,
                                  model.yearlyRebate.results[index].rebate,
                                  model.yearlyRebate.results[index].expenses,
                                  DateTimeUtils.getMonthName(DateTime(
                                      DateTime.now().year,
                                      model.yearlyRebate.results[index]
                                          .monthId)),
                                  model.yearlyRebate.results[index].year);
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDropdownFilter() {
    return Container(
      color: const Color.fromRGBO(121, 85, 72, 1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 4.0),
                child: Text(
                  'Filter by',
                  style: TextStyle(
                    fontSize: 16.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 2.0),
                child: Text(
                  'Year',
                  style: TextStyle(
                      color: const Color.fromRGBO(0, 0, 0, 0.54),
                      fontSize: 16.5),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color:
                                        const Color.fromRGBO(0, 0, 0, 0.15)))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: currentItemSelected,
                            items: _yearList.map((int dropDownItem) {
                              return DropdownMenuItem<int>(
                                value: dropDownItem,
                                child: Text(
                                  '$dropDownItem',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (int newValueSelected) {
                              _onDropDownItemSelected(newValueSelected);
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onDropDownItemSelected(int newValueSelected) {
    setState(() {
      currentItemSelected = newValueSelected;
    });
  }
}
