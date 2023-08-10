import 'package:appetizer_revamp_parts/ui/notifications/bloc/notification_page_bloc.dart';
import 'package:appetizer_revamp_parts/ui/notifications/components/no_notification_widget.dart';
import 'package:appetizer_revamp_parts/ui/notifications/components/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0xFFFFCB74),
        toolbarHeight: 120,
      ),
      // TODO: implement Old/New notification bars and logic
      body: BlocProvider(
        create: (context) => NotificationPageBloc(),
        child: BlocBuilder<NotificationPageBloc, NotificationPageState>(
          builder: (context, state) {
            if (state is NotificationPageInitialState) {
              context
                  .read<NotificationPageBloc>()
                  .add(const NotificationPageFetchEvent(notifications: []));
              // TODO: place proper widget
              return const Placeholder();
            }
            if (state is NotificationPageFailedState) {
              // TODO: throw an error, or snackbar
            }
            if (state is NotificationPageFetchedState) {
              if (state.notifications.isEmpty) {
                return const NoNotificationsWidget();
              }
              return Container(
                padding: const EdgeInsets.only(left: 24, right: 25, top: 32),
                child: ListView.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        NotificationCard(
                          data: state.notifications[index],
                        ),
                        index < state.notifications.length
                            ? const SizedBox(
                                height: 16,
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
                  },
                ),
              );
            }
            return const NoNotificationsWidget();
          },
        ),
      ),
    );
  }
}
