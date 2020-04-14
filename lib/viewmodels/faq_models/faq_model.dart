import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/transaction/faq.dart';
import 'package:appetizer/services/api/transaction.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class FaqModel extends BaseModel {
  final TransactionApi _transactionApi = locator<TransactionApi>();

  List<Faq> _faqs;

  List<Faq> get faqs => _faqs;

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
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
