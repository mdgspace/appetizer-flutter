import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class QRGeneratorModel extends BaseModel {
  final MultimessingApi _multimessingApi = locator<MultimessingApi>();

  String _secretCode;

  String get secretCode => _secretCode;

  set secretCode(String secretCode) {
    _secretCode = secretCode;
    notifyListeners();
  }

  Future fetchSecretCode(int switchId) async {
    try {
      setState(ViewState.Busy);
      var switchDetails = await _multimessingApi.getSwitchDetails(switchId);
      secretCode = switchDetails.secretCode;
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
