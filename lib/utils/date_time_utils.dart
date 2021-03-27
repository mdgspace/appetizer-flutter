import 'package:intl/intl.dart';

class DateTimeUtils {
  static String getWeekDayName(DateTime _dateTime) {
    return DateFormat('EEEE').format(_dateTime);
  }

  static String getMonthName(DateTime _dateTime) {
    return DateFormat('LLLL').format(_dateTime);
  }

  static int getWeekNumber(DateTime dateTime) {
    var dayOfYear = int.parse(DateFormat('D').format(dateTime));
    return ((dayOfYear - dateTime.weekday + 10) / 7).floor();
  }

  static String dateTime(int timeStamp) {
    var dateTimeString = DateTime.fromMillisecondsSinceEpoch(timeStamp)
        .toLocal()
        .toString()
        .substring(0, 19);
    return dateTimeString;
  }
}
