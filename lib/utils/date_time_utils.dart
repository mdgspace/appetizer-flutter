import 'package:intl/intl.dart';

class DateTimeUtils {
  static String getDashedDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static DateTime getDateTimeFromDateAndTime(DateTime date, String time) {
    return DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse('${date.toString().substring(0, 10)} $time');
  }

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
