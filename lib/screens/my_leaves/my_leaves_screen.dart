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
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            StatusCard2(24, true),
            InfoMessage('Check-out to leave upcoming meals in sequence'),
            ManageLeaveBanner(),
            //TODO: USE MAP FOR THE MEALS LEFT
            MealLeft('Dinner', 'July 16 2019'),
            MealLeft('Lunch', 'July 18 2019'),
            InfoMessage('You can cancel your leave 2-3 hours before the meal'),
            SeeHistory(),
//        }else{
//    NoLeaves()
//  }
          ],
        ),
      ),
    );
  }
}