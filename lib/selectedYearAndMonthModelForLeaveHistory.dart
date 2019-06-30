import 'package:flutter/foundation.dart';

class YearAndMonthModel with ChangeNotifier {

  int _currentYearSelected = DateTime.now().year;
  String _currentMonthSelected = 'All';

  int get currentYearSelected => _currentYearSelected;

  set currentYearSelected(int value) {
    _currentYearSelected = value;
    notifyListeners();
  }

  String get currentMonthSelected => _currentMonthSelected;

  set currentMonthSelected(String value) {
    _currentMonthSelected = value;
    notifyListeners();
  }
}
