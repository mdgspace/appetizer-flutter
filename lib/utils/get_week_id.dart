import 'package:intl/intl.dart';

int getWeekNumber(DateTime dateTime) {
  int dayOfYear = int.parse(DateFormat("D").format(dateTime));
  return ((dayOfYear - dateTime.weekday + 10) / 7).floor();
}
