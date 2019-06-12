import 'package:flutter/material.dart';

import 'rebate_dropdown_filter.dart';
import 'rebate_history_card.dart';

class NotificationHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          color: const Color.fromRGBO(255, 193, 7, 1),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text("Notification History"),
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 140.0,
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
