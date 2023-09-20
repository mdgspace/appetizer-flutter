import 'package:intl/intl.dart';

class DateTimeUtils {
  static String getDashedDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static DateTime getDateTimeFromDateAndTime(DateTime date, String time) {
    return DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse('${date.toString().substring(0, 10)} $time');
  }

  static String getWeekDayName(DateTime dateTime) {
    return DateFormat('EEEE').format(dateTime);
  }

  static String getMonthName(DateTime dateTime) {
    return DateFormat('LLLL').format(dateTime);
  }

  static int getWeekNumber(DateTime dateTime) {
    var dayOfYear = int.parse(DateFormat('D').format(dateTime));
    return ((dayOfYear - dateTime.weekday + 10) / 7).floor();
  }

  static String dateTime(int timeStamp) {
    return DateFormat.yMd()
        .add_jms()
        .format(DateTime.fromMillisecondsSinceEpoch(timeStamp));
  }

  static DateTime getWeekStartDate(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - DateTime.monday));
  }

  static bool compareDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
