import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/notification_history/notification.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/notifications/notifications_viewmodel.dart';
import 'package:flutter/material.dart';

class NotificationHistory extends StatelessWidget {
  static const String id = 'notification_history_view';

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationsViewModel>(
      onModelReady: (model) => model.getNotifications(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Notifications History',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: model.state == ViewState.Busy
              ? AppetizerProgressWidget()
              : model.state == ViewState.Error
                  ? AppetizerErrorWidget(errorMessage: model.errorMessage)
                  : ListView.builder(
                      itemCount: model.notifications.length,
                      itemBuilder: (BuildContext context, int index) {
                        return MessNotification(
                            model.notifications[index].title,
                            model.notifications[index].message,
                            DateTimeUtils.dateTime(
                                model.notifications[index].dateCreated));
                      },
                    ),
        ),
      ),
    );
  }
}
