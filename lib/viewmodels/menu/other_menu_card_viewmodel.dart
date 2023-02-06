import 'package:appetizer/locator.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/services/api/multimessing_api.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/ui/multimessing/switch_confirmed_view.dart';
import 'package:appetizer/viewmodels/base_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OtherMenuCardViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final MultimessingApi _multimessingApi = locator<MultimessingApi>();

  Future<void> onSwitchTapped(Meal meal) async {
    if (meal.isLeaveToggleOutdated) return;

    if (meal.switchStatus.status == SwitchStatusEnum.N) {
      await Get.toNamed(SwitchConfirmedView.id);
    }

    if (meal.switchStatus.status == SwitchStatusEnum.T ||
        meal.switchStatus.status == SwitchStatusEnum.F) {
      var _dialogResponse = await _dialogService.showConfirmationDialog(
        title: 'Cancel Switch',
        description: 'Are you sure you want to cancel this switch?',
      );

      if (_dialogResponse.confirmed) {
        _dialogService.showCustomProgressDialog(title: 'Cancelling Switch');
        var _isSwitchCancelled =
            await _multimessingApi.cancelSwitch(meal.switchStatus.id);
        _dialogService.popDialog();

        if (_isSwitchCancelled) {
          notifyListeners();
        } else {
          await Fluttertoast.showToast(msg: 'Unable to cancel the switch');
        }
      }
    }
  }
}
