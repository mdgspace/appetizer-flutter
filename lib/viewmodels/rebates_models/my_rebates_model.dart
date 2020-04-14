import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/transaction/current_month_rebate.dart';
import 'package:appetizer/services/api/transaction.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class MyRebatesModel extends BaseModel {
  TransactionApi _transactionApi = locator<TransactionApi>();

  MonthlyRebate _monthlyRebate;

  MonthlyRebate get monthlyRebate => _monthlyRebate;

  set monthlyRebate(MonthlyRebate monthlyRebate) {
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
