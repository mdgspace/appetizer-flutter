import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/transaction/paginated_yearly_rebate.dart';
import 'package:appetizer/services/api/transaction_api.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class RebatesHistoryViewModel extends BaseModel {
  final TransactionApi _transactionApi = locator<TransactionApi>();

  late PaginatedYearlyRebate _yearlyRebate;

  PaginatedYearlyRebate get yearlyRebate => _yearlyRebate;

  set yearlyRebate(PaginatedYearlyRebate yearlyRebate) {
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
