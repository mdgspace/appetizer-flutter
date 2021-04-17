import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/leave_api.dart';
import 'package:appetizer/services/api/multimessing_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/ui/multimessing/switchable_meals_view.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class YourMenuCardViewModel extends BaseModel {
  final LeaveApi _leaveApi = locator<LeaveApi>();
  final MultimessingApi _multimessingApi = locator<MultimessingApi>();
  final DialogService _dialogService = locator<DialogService>();

  Meal _meal;

  Meal get meal => _meal;

  set meal(Meal meal) {
    _meal = meal;
    notifyListeners();
  }

  DailyItems _dailyItems;

  DailyItems get dailyItems => _dailyItems;

  set dailyItems(DailyItems dailyItems) {
    _dailyItems = dailyItems;
    notifyListeners();
  }

  bool _mealLeaveStatus;

  bool get mealLeaveStatus => _mealLeaveStatus;

  set mealLeaveStatus(bool mealLeaveStatus) {
    _mealLeaveStatus = mealLeaveStatus;
    notifyListeners();
  }

  bool _mealSwitchStatus;

  bool get mealSwitchStatus => _mealSwitchStatus;

  set mealSwitchStatus(bool mealSwitchStatus) {
    _mealSwitchStatus = mealSwitchStatus;
    notifyListeners();
  }

  String _secretCode;

  String get secretCode => _secretCode;

  set secretCode(String secretCode) {
    _secretCode = secretCode;
    notifyListeners();
  }

  bool _isLeaveToggleOutdated;

  bool get isLeaveToggleOutdated => _isLeaveToggleOutdated;

  set isLeaveToggleOutdated(bool isLeaveToogleOutdated) {
    _isLeaveToggleOutdated = isLeaveToogleOutdated;
    notifyListeners();
  }

  bool _isLeaveCancelled;

  bool get isLeaveCancelled => _isLeaveCancelled;

  set isLeaveCancelled(bool isLeaveCancelled) {
    _isLeaveCancelled = isLeaveCancelled;
    notifyListeners();
  }

  bool _isSwitchCancelled;

  bool get isSwitchCancelled => _isSwitchCancelled;

  set isSwitchCancelled(bool isSwitchCancelled) {
    _isSwitchCancelled = isSwitchCancelled;
    notifyListeners();
  }

  void updateMealLeaveAndSwitchStatus(Meal meal) {
    if (meal != null) {
      _mealLeaveStatus =
          _meal?.leaveStatus?.status == LeaveStatusEnum.N ? true : false;
      _mealSwitchStatus =
          _meal?.switchStatus?.status == SwitchStatusEnum.N ? true : false;
    } else {
      _mealLeaveStatus = true;
      _mealSwitchStatus = false;
    }
    notifyListeners();
  }

  Future cancelLeave(int id) async {
    try {
      isLeaveCancelled = await _leaveApi.cancelLeave(id);
      if (isLeaveCancelled) {
        await Fluttertoast.showToast(msg: 'Leave Cancelled');
      }
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
      await Fluttertoast.showToast(msg: errorMessage);
      mealLeaveStatus = !mealLeaveStatus;
    }
  }

  Future leaveMeal(int id) async {
    try {
      var _leaveCreated = await _leaveApi.leave(id.toString());
      if (_leaveCreated == true) {
        await Fluttertoast.showToast(msg: 'Meal Skipped');
      }
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
      await Fluttertoast.showToast(msg: errorMessage);
      mealLeaveStatus = !mealLeaveStatus;
    }
  }

  Future cancelSwitch(int id) async {
    try {
      isSwitchCancelled = await _multimessingApi.cancelSwitch(id);
      await Fluttertoast.showToast(msg: 'Switch Cancelled');
    } on Failure catch (f) {
      setState(ViewState.Error);
      setErrorMessage(f.message);
      await Fluttertoast.showToast(msg: errorMessage);
    }
  }

  Future onLeaveChanged(bool value) async {
    mealLeaveStatus = value;
    if (mealSwitchStatus) {
      if (value) {
        if (!isLeaveToggleOutdated) {
          var _dialogResponse = await _dialogService.showConfirmationDialog(
            title: 'Cancel Leave',
            description: 'Are you sure you would like to cancel this leave?',
            confirmationTitle: 'CANCEL LEAVE',
          );

          if (_dialogResponse.confirmed) {
            _dialogService.showCustomProgressDialog(title: 'Cancelling Leave');
            await cancelLeave(meal.id);
            _dialogService.popDialog();
          } else {
            mealLeaveStatus = !mealLeaveStatus;
          }
        } else {
          await Fluttertoast.showToast(
            msg:
                'Leave status cannot be changed less than ${Globals.outdatedTime.inHours} hours before the meal time',
          );
        }
      } else {
        if (!isLeaveToggleOutdated) {
          var _dialogResponse = await _dialogService.showConfirmationDialog(
            title: 'Leave Meal',
            description: 'Are you sure you would like to leave this meal?',
            confirmationTitle: 'SKIP MEAL',
          );

          if (_dialogResponse.confirmed) {
            _dialogService.showCustomProgressDialog(title: 'Leaving Meal');
            await leaveMeal(meal.id);
            _dialogService.popDialog();
          } else {
            mealLeaveStatus = !mealLeaveStatus;
          }
        }
      }
    }
  }

  Future onSwitchChanged() async {
    if (!isLeaveToggleOutdated) {
      if (mealSwitchStatus) {
        await Get.toNamed(SwitchableMealsView.id, arguments: meal.id);
      } else {
        if (meal.switchStatus.status == SwitchStatusEnum.T ||
            meal.switchStatus.status == SwitchStatusEnum.F) {
          var _dialogResponse = await _dialogService.showConfirmationDialog(
            title: 'Cancel Switch',
            description: 'Are you sure you want to cancel this switch?',
          );

          if (_dialogResponse.confirmed) {
            _dialogService.showCustomProgressDialog(title: 'Cancelling Switch');
            await cancelSwitch(meal.switchStatus.id);
            _dialogService.popDialog();
            if (isSwitchCancelled) {
              Get.key.currentState.popUntil((route) => route.isFirst);
              mealSwitchStatus = true;
            }
          }
        }
      }
    }
  }

  void onSwitchDragged() {
    if (isLeaveToggleOutdated) {
      Fluttertoast.showToast(
        msg:
            'Leave status cannot be changed less than ${Globals.outdatedTime.inHours} hours before the meal time',
      );
    } else if (!mealSwitchStatus) {
      Fluttertoast.showToast(
        msg: 'Leave Status cannot be changed when Switch is active !!',
      );
    }
  }

  VoidCallback onQRTapped() {
    switch (meal.switchStatus.status) {
      case SwitchStatusEnum.N:
      case SwitchStatusEnum.A:
        return () {};
        break;
      case SwitchStatusEnum.D:
        return () {
          Fluttertoast.showToast(msg: 'Your switch has been denied');
        };
        break;
      case SwitchStatusEnum.F:
      case SwitchStatusEnum.T:
        return () {
          if (meal.endDateTime
              .add(Duration(hours: 1))
              .isBefore(DateTime.now())) {
            Fluttertoast.showToast(msg: 'Time for this meal has passed!');
          } else if (meal.startTime
              .subtract(Globals.outdatedTime)
              .isAfter(DateTime.now())) {
            Fluttertoast.showToast(
                msg: 'QR CODE will be available 8 hours before the meal');
          } else {
            secretCode = '1';
          }
        };
        break;
      case SwitchStatusEnum.U:
        return () {
          Fluttertoast.showToast(msg: 'Your Switch was not approved!');
        };
        break;
      default:
        return () {};
    }
  }
}
