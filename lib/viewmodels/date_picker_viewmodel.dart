import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class DatePickerViewModel extends BaseModel {
  DateTime dateTime;

  int weekId;

  bool weekDidChange;

  void setDateTime(DateTime value) {
    dateTime = value;
    if (weekId != DateTimeUtils.getWeekNumber(value)) {
      weekDidChange = true;
      weekId = DateTimeUtils.getWeekNumber(value);
    } else {
      weekDidChange = false;
    }
    print('CurrentDateModel: $dateTime');
    notifyListeners();
  }
}
