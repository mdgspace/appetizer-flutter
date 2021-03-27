import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/error_widget.dart';
import 'package:appetizer/ui/components/progress_bar.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/notification_models/notifications_model.dart';
import 'package:flutter/material.dart';

import 'notification.dart';

class NotificationHistory extends StatelessWidget {
  static const String id = 'notification_history_view';

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationsModel>(
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
              ? ProgressBar()
              : model.state == ViewState.Error
                  ? AppiErrorWidget(message: model.errorMessage)
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
