import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/transaction_api.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class MyRebatesViewModel extends BaseModel {
  final TransactionApi _transactionApi = locator<TransactionApi>();

  int _monthlyRebate;

  int get monthlyRebate => _monthlyRebate;

  set monthlyRebate(int monthlyRebate) {
    _monthlyRebate = monthlyRebate;
    notifyListeners();
  }

  Future getMonthlyRebate() async {
    setState(ViewState.Busy);
    try {
      monthlyRebate = await _transactionApi.getMonthlyRebate();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
