import 'package:flutter/material.dart';

import 'rebate_dropdown_filter.dart';
import 'rebate_history_card.dart';

class RebateHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            child: RebateDropdownFilter(),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                //TODO: IMPLEMENT CHANGE IN LIST VIEW ON NEW SELECTION
                //TODO: USE MAP FOR IMPLEMENTING HISTORY
                RebateHistoryCard(1800, 403, 0, 'April', 2019),
                RebateHistoryCard(1800, 403, 0, 'March', 2019),
                RebateHistoryCard(1800, 403, 0, 'February', 2019),
                RebateHistoryCard(1800, 403, 0, 'January', 2019),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String monthIdToMonthString(int id) {
  switch (id) {
    case 1:
      {
        return "January";
      }
      break;
    case 2:
      {
        return "February";
      }
      break;
    case 3:
      {
        return "March";
      }
      break;
    case 4:
      {
        return "April";
      }
      break;
    case 5:
      {
        return "May";
      }
      break;
    case 6:
      {
        return "June";
      }
      break;
    case 7:
      {
        return "July";
      }
      break;
    case 8:
      {
        return "August";
      }
      break;
    case 9:
      {
        return "September";
      }
      break;
    case 10:
      {
        return "October";
      }
      break;
    case 11:
      {
        return "November";
      }
      break;
    default:
      {
        return "December";
      }
      break;
  }
}
