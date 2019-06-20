import 'package:flutter/material.dart';

import 'data_classes.dart';
import 'month_timeline.dart';

class LeaveTimeline extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        MonthTimeline(new TimelineData(2019, 'JAN', <LeaveDetailsData>[])),
        MonthTimeline(new TimelineData(2019, 'JAN', <LeaveDetailsData>[])),
        MonthTimeline(new TimelineData(2019, 'JAN', <LeaveDetailsData>[])),
      ],
    );
  }
}
