import 'package:flutter/material.dart';
import "colors.dart";
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, WeekdayFormat;
import 'package:flutter_calendar_carousel/classes/event.dart';

class HorizontalDatePicker extends StatefulWidget {
  @override
  _HorizontalDatePickerState createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  CalendarCarousel _calendarCarousel;
  DateTime _currentDate = DateTime.now();
  double _fontSizeDate = 14.0;
  @override
  Widget build(BuildContext context) {
    _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() {
          _currentDate = date;

        });
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
      showWeekDays: true,

      height: 80.0,
      selectedDateTime: _currentDate,
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

    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.brown,
      child: _calendarCarousel,
    );
  }
}
