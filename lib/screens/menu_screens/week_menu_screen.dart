import 'package:flutter/material.dart';

import '../../colors.dart';

class WeekMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _headerTextStyle = TextStyle(color: Color(0xffFFC107), fontSize: 16);

    final  _headerRow = Container(
      padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: appiBrown,
        ),
        child:
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  'Day'.toUpperCase(),
                  style: _headerTextStyle,
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'Breakfast'.toUpperCase(),
                    style: _headerTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'Lunch'.toUpperCase(),
                    style: _headerTextStyle,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'Dinner'.toUpperCase(),
                    style: _headerTextStyle,
                  ),
                ),
              ),
            ],
          ),
        );

    final dummy = _buildTableRow("S", 21, [
      "Fried Maggi",
      "Veg. Sauce",
      "Dalia",
      "Chocoes",
    ], [
      "Fried Maggi",
      "Veg. Sauce",
      "Dalia",
      "Chocoes",
    ], [
      "Fried Maggi",
      "Veg. Sauce",
      "Dalia",
      "Chocoes",
    ]);

    return Column(
      children: <Widget>[
        _headerRow,
        Flexible(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              dummy,
              dummy,
              dummy,
              dummy,
              dummy,
              dummy,
              dummy,
              dummy,
              dummy,
              dummy,
            ],
          ),
        ),
      ],
    );
  }

  _buildTableRow(String day, int date, List<String> breakfast,
      List<String> lunch, List<String> dinner) {
    
    final dateWidget = Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Color(0xfff5f5f5),
            border: Border(right: BorderSide(color: Color(0xff828282)))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xfff6f6f6)),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: Text(day, style: TextStyle(fontSize: 18, ),)),
                ),
              ),
            ),
            Text(date.toString(), style: TextStyle(color: Color(0xff333333), fontSize: 12),),
          ],
        ));

    subMapper(List<String> list) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xff828282)),
                right: BorderSide(color: Color(0xff828282)))),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list.map((str) => Text(str, style: TextStyle(fontSize: 12),)).toList(),
        ),
      );
    }

    final List<Widget> _rowEntries = [
      Expanded(flex: 1, child: dateWidget),
      Expanded(flex: 2, child: subMapper(breakfast)),
      Expanded(flex: 2, child: subMapper(lunch)),
      Expanded(flex: 2, child: subMapper(dinner))
    ];

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _rowEntries);
  }
}
