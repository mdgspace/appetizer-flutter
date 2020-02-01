import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:appetizer/change_notifiers/menu_model.dart';
import 'package:provider/provider.dart';

class CurrentDateModel with ChangeNotifier {
  DateTime _dateTime;
  int _weekId;
  bool _weekDidChange;

  CurrentDateModel() {
    _dateTime = DateTime.now();
    _weekId = DateTimeUtils.getWeekNumber(_dateTime);
    _weekDidChange = false;
  }

  DateTime get dateTime => _dateTime;
  bool get weekDidChange => _weekDidChange;
  int get weekId => _weekId;

  void  setDateTime(DateTime value, BuildContext context) {
    _dateTime = value;
    if(_weekId != DateTimeUtils.getWeekNumber(value)){
      _weekDidChange = true;
      _weekId = DateTimeUtils.getWeekNumber(value);
    }else{
      _weekDidChange = false;
    }
    notifyListeners();
  }

}
