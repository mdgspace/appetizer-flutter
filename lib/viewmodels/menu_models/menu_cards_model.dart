import 'package:appetizer/viewmodels/base_model.dart';

class MenuCardsModel extends BaseModel {
  bool _isLeaveCancelled;

  bool get isLeaveCancelled => _isLeaveCancelled;

  set isLeaveCancelled(bool isLeaveCancelled) {
    _isLeaveCancelled = isLeaveCancelled;
    notifyListeners();
  }
}
