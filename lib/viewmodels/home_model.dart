import 'package:appetizer/viewmodels/base_model.dart';

class HomeModel extends BaseModel {
  String _selectedHostel = "Your Meals";

  String get selectedHostel => _selectedHostel;

  set selectedHostel(String selectedHostel) {
    _selectedHostel = selectedHostel;
    notifyListeners();
  }
}
