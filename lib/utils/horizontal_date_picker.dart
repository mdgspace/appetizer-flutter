import 'package:appetizer/colors.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/screens/my_leaves/my_leaves_screen.dart';
import 'package:appetizer/services/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../flutter_calendar_carousel/classes/event.dart';
import '../flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, WeekdayFormat;
import '../provider/current_date.dart';

class HorizontalDatePicker extends StatefulWidget {
  final String token;

  const HorizontalDatePicker({Key key, this.token}) : super(key: key);

  @override
  _HorizontalDatePickerState createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  CalendarCarousel _calendarCarousel;
  double _fontSizeDate = 14.0;

  @override
  void initState() {
    super.initState();
    userMeGet(widget.token).then((me) {
      setState(() {
        isCheckedOut = me.isCheckedOut;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentSelectedDate = Provider.of<CurrentDateModel>(context);

    _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        currentSelectedDate.dateTime = date;
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: TextStyle(color: Colors.white, fontSize: _fontSizeDate),
      weekdayTextStyle: TextStyle(color: Colors.white),
      daysHaveCircularBorder: true,
      thisMonthDayBorderColor: Colors.white,
      daysTextStyle: TextStyle(color: Colors.white, fontSize: _fontSizeDate),
      selectedDayTextStyle:
          TextStyle(color: Colors.black, fontSize: _fontSizeDate),
      todayTextStyle: TextStyle(color: Colors.black, fontSize: _fontSizeDate),
      weekFormat: true,
      showHeader: false,
      weekDayFormat: WeekdayFormat.standaloneNarrow,
      firstDayOfWeek: 1,
      showWeekDays: true,
      height: 80.0,
      selectedDateTime: currentSelectedDate.dateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      selectedDayButtonColor: Colors.yellow[800],
      selectedDayBorderColor: Colors.yellow[800],
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      todayButtonColor: null,
      todayBorderColor: Colors.yellow[800],
      dayPadding: 8,
    );

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.brown,
          child: _calendarCarousel,
        ),
        isCheckedOut == null
            ? Container()
            : isCheckedOut
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    color: appiRed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: Center(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "You are currently Checked-Out",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyLeaves(
                                          token: widget.token,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                            child: Text(
                              "CHECK-IN",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
      ],
    );
  }
}
