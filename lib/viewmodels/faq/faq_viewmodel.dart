import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/transaction/faq.dart';
import 'package:appetizer/services/api/transaction_api.dart';
import 'package:appetizer/utils/snackbar_utils.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class FaqViewModel extends BaseModel {
  final TransactionApi _transactionApi = locator<TransactionApi>();

  List<Faq>? _faqs;

  List<Faq> get faqs => _faqs ?? [];

  set faqs(List<Faq> faqs) {
    _faqs = faqs;
    notifyListeners();
  }

  Future getFaqs() async {
    setState(ViewState.Busy);
    try {
      faqs = await _transactionApi.getFAQ();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
      SnackBarUtils.showDark('Error', f.message);
    }
  }
}
