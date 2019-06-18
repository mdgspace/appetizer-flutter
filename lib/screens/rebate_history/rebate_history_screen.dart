import 'package:appetizer/services/transaction.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/monthIntToMonthString.dart';

import '../../colors.dart';
import '../../login.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color.fromRGBO(255, 193, 7, 1),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text("Rebate History", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 150.0,
            child: getDropdownFilter(),
          ),
          Expanded(
            child: getRebateHistoryList()
            /*ListView(
              children: <Widget>[
                RebateHistoryCard(1800, 403, 0, 'April', 2019),
                RebateHistoryCard(1800, 403, 0, 'March', 2019),
                RebateHistoryCard(1800, 403, 0, 'February', 2019),
                RebateHistoryCard(1800, 403, 0, 'January', 2019),
              ],
            ),*/
          ),
        ],
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

  Widget getRebateHistoryList() {
    getUserDetails().then((userDetails) {
      return FutureBuilder(
        future: getYearlyRebate(
            userDetails.getString("token"), currentItemSelected),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(appiYellow),
              )),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.count,
                itemBuilder: (BuildContext context, int index) {
                  return RebateHistoryCard(
                      null,
                      snapshot.data.results[index].rebate,
                      snapshot.data.results[index].expenses,
                      monthIntToMonthString(
                          snapshot.data.results[index].monthId),
                      snapshot.data.results[index].year);
                });
          }
        },
      );
    });
    return Container(
      width: 0.0,
      height: 0.0,
    );
  }
}
