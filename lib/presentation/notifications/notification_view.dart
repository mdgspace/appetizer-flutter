import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/repositories/user/user_repository.dart';
import 'package:appetizer/presentation/components/no_data_found_container.dart';
import 'package:appetizer/presentation/notifications/bloc/notification_page_bloc.dart';
import 'package:appetizer/presentation/notifications/components/no_notification_widget.dart';
import 'package:appetizer/presentation/notifications/components/notification_banner.dart';
import 'package:appetizer/presentation/notifications/components/notification_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: implement Old/New notification bars and logic
      body: BlocProvider(
        create: (context) =>
            NotificationPageBloc(repo: context.read<UserRepository>()),
        child: BlocBuilder<NotificationPageBloc, NotificationPageState>(
          builder: (context, state) {
            if (state is NotificationPageInitialState) {
              context
                  .read<NotificationPageBloc>()
                  .add(const NotificationPageFetchEvent(notifications: []));
              return const NoDataFoundContainer(
                  title: 'Oops! Just a moment...');
            }
            if (state is NotificationPageFailedState) {
              // TODO: throw an error, or snackbar
              return const NoDataFoundContainer(
                  title: 'Something went wrong...');
            }
            if (state is NotificationPageFetchedState) {
              if (state.notifications.isEmpty) {
                return const NoNotificationsWidget();
              }
              return Column(
                children: [
                  const NotificationBanner(),
                  Container(
                    height: 656.toAutoScaledHeight,
                    padding: EdgeInsets.only(
                        left: 24.toAutoScaledWidth,
                        right: 25.toAutoScaledWidth,
                        top: 32.toAutoScaledHeight),
                    child: ListView.builder(
                      itemCount: state.notifications.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            NotificationCard(
                              data: state.notifications[index],
                            ),
                            index < state.notifications.length
                                ? 16.toVerticalSizedBox
                                : const SizedBox.shrink(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const NoDataFoundContainer(title: 'Something went wrong !');
          },
        ),
      ),
    );
  }
}
