import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/leaves/check.dart';
import 'package:appetizer/models/user/me.dart';
import 'package:appetizer/services/api/leave.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class LeaveStatusCardModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();
  final LeaveApi _leaveApi = locator<LeaveApi>();
  final DialogService _dialogService = locator<DialogService>();

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

  Future toggleCheckState() async {
    setState(ViewState.Busy);
    try {
      var check = await _leaveApi.check();
      isCheckedOut = check.isCheckedOut;
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }

  Future onCheckTapped() async {
    if (!isCheckedOut) {
      var dialogResponse = await _dialogService.showConfirmationDialog(
          title: 'Check Out',
          description: 'Are you sure you would like to check out?',
          confirmationTitle: 'CHECK OUT');

      if (dialogResponse.confirmed) {
        await toggleCheckState();
        if (isCheckedOut) {
          showSnackBar(myLeavesViewScaffoldKey, 'You have checked out');
        }
      }
    } else {
      await toggleCheckState();
      if (!isCheckedOut) {
        showSnackBar(myLeavesViewScaffoldKey, 'You have checked in');
      }
    }
  }
}
