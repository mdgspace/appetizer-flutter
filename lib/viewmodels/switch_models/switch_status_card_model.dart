import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class SwitchStatusCardModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();

  // bool _isCheckedOut;
  String _imageUrl;

  // bool get isCheckedOut => _isCheckedOut;

  // set isCheckedOut(bool isCheckedOut) {
  //   _isCheckedOut = isCheckedOut;
  //   notifyListeners();
  // }

  String get imageUrl => _imageUrl;

  set imageUrl(String imageUrl) {
    _imageUrl = imageUrl;
    notifyListeners();
  }

  Future setInitialValues() async {
    setState(ViewState.Busy);
    try {
      var me = await _userApi.userMeGet();
      setState(ViewState.Idle);
      isCheckedOut = me.isCheckedOut;
      imageUrl = me.imageUrl;
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
