import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/failure_model.dart';
import 'package:appetizer/models/user/notification.dart';
import 'package:appetizer/services/api/user_api.dart';
import 'package:appetizer/viewmodels/base_model.dart';

class NotificationsViewModel extends BaseModel {
  final UserApi _userApi = locator<UserApi>();

  List<Notification> _notifications = [];

  List<Notification> get notifications => _notifications;

  set notifications(List<Notification> notifications) {
    _notifications = notifications;
    notifyListeners();
  }

  Future getNotifications() async {
    setState(ViewState.Busy);
    try {
      notifications = await _userApi.getNotifications();
      setState(ViewState.Idle);
    } on Failure catch (f) {
      print(f.message);
      setErrorMessage(f.message);
      setState(ViewState.Error);
    }
  }
}
