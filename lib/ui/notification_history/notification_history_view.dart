import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/notification_history/components/mess_notification.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/viewmodels/notifications/notifications_viewmodel.dart';
import 'package:flutter/material.dart';

class NotificationHistoryView extends StatelessWidget {
  static const String id = 'notification_history_view';

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationsViewModel>(
      onModelReady: (model) => model.getNotifications(),
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'Notification History'),
        body: () {
          switch (model.state) {
            case ViewState.Idle:
              return Visibility(
                visible: model.notifications.isNotEmpty,
                replacement: Center(
                  child: Text(
                    'No Notifications yet!',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                child: ListView.separated(
                  itemCount: model.notifications.length,
                  itemBuilder: (context, index) => MessNotification(
                    model.notifications[index].title,
                    model.notifications[index].message,
                    DateTimeUtils.dateTime(
                        model.notifications[index].dateCreated),
                  ),
                  separatorBuilder: (context, index) => Divider(height: 8),
                ),
              );
              break;
            case ViewState.Busy:
              return AppetizerProgressWidget();
              break;
            case ViewState.Error:
              return AppetizerErrorWidget(
                errorMessage: model.errorMessage,
                onRetryPressed: () => model.getNotifications(),
              );
              break;
            default:
              return Container();
          }
        }(),
      ),
    );
  }
}
