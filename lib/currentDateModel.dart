import 'package:flutter/foundation.dart';

class CurrentDateModel with ChangeNotifier{
  DateTime _dateTime = DateTime.now();

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    _dateTime = value;
    notifyListeners();
  }
}