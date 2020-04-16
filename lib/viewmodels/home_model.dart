import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/services/api/multimessing.dart';
import 'package:appetizer/services/api/user.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeModel extends BaseModel {
  MultimessingApi _multimessingApi = locator<MultimessingApi>();
  UserApi _userApi = locator<UserApi>();

  String _selectedHostel = "Your Meals";

  String get selectedHostel => _selectedHostel;

  set selectedHostel(String selectedHostel) {
    _selectedHostel = selectedHostel;
    notifyListeners();
  }

  List<String> _switchableHostelsList = ["Your Meals"];

  List<String> get switchableHostelsList => _switchableHostelsList;

  Future setSwitchableHostels() async {
    try {
      var switchableHostels = await _multimessingApi.switchableHostels();
      switchableHostels.forEach((hostel) {
        switchableHostelsList.add(hostel[2].toString());
      });
      notifyListeners();
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      Fluttertoast.showToast(msg: f.message);
    }
  }

  Future fetchInitialCheckedStatus() async {
    try {
      var userDetails = await _userApi.userMeGet();
      isCheckedOut = userDetails.isCheckedOut;
      notifyListeners();
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
    }
  }

  Future onModelReady() async {
    await setSwitchableHostels();
    await fetchInitialCheckedStatus();
  }
}
