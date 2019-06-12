import 'package:flutter/material.dart';

import 'status_card_1.dart';
import 'status_card_2.dart';
import 'meal_left.dart';
import 'info_message.dart';
import 'manage_leaves_banner.dart';
import 'no_leaves.dart';
import 'see_history.dart';

class MyLeaves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          color: const Color.fromRGBO(255, 193, 7, 1),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text("My Leaves"),
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 262.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StatusCard2(24, true),
                InfoMessage('Check-out to leave upcoming meals in sequence'),
                ManageLeaveBanner(),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                //TODO: USE MAP FOR THE MEALS LEFT
                MealLeft('Dinner', 'July 16 2019'),
                MealLeft('Dinner', 'July 16 2019'),
                MealLeft('Dinner', 'July 16 2019'),
              ],
            ),
          ),
          Container(
            height: 103.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InfoMessage('You can cancel your leave 2-3 hours before the meal'),
                SeeHistory(),
              ],
            ),
          )
//        }else{
//    NoLeaves()
//  }
        ],
      ),
    );
  }
}