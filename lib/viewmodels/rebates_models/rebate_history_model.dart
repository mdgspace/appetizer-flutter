import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/transaction/yearly_rebate.dart';
import 'package:appetizer/services/api/transaction.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class RebateHistoryModel extends BaseModel {
  final TransactionApi _transactionApi = locator<TransactionApi>();

  YearlyRebate _yearlyRebate;

  YearlyRebate get yearlyRebate => _yearlyRebate;

  set yearlyRebate(YearlyRebate yearlyRebate) {
    _yearlyRebate = yearlyRebate;
    notifyListeners();
  }

  Future getYearlyRebate(int year) async {
    setState(ViewState.Busy);
    try {
      yearlyRebate = await _transactionApi.getYearlyRebate(year);
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
