import 'package:appetizer/app_theme.dart';
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
      backgroundColor: AppTheme.white,
      // TODO: implement Old/New notification bars and logic
      body: Column(
        children: [
          const NotificationBanner(),
          Expanded(
            child: BlocProvider(
              create: (context) =>
                  NotificationPageBloc(repo: context.read<UserRepository>()),
              child: BlocBuilder<NotificationPageBloc, NotificationPageState>(
                builder: (context, state) {
                  if (state is NotificationPageInitialState) {
                    context.read<NotificationPageBloc>().add(
                        const NotificationPageFetchEvent(notifications: []));
                    return const NoDataFoundContainer(
                        title: 'Oops! Just a moment...');
                  }
                  if (state is NotificationPageFailedState) {
                    // TODO: throw an error, or snackbar
                    return const NoDataFoundContainer(
                        title: 'Something went wrong...');
                  }
                  if (state is NotificationPageFetchedState) {
                    return Visibility(
                      visible: state.notifications.isNotEmpty,
                      replacement: const NoNotificationsWidget(),
                      child: ListView.separated(
                        padding: 24.toHorizontalPadding,
                        shrinkWrap: true,
                        itemCount: state.notifications.length,
                        separatorBuilder: (context, index) =>
                            16.toVerticalSizedBox,
                        itemBuilder: (context, index) {
                          return NotificationCard(
                            data: state.notifications[index],
                          );
                        },
                      ),
                    );
                  }
                  return const NoDataFoundContainer(
                      title: 'Something went wrong !');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
