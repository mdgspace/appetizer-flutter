import 'package:appetizer/ui/notifications/bloc/notification_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchBarWidget extends StatelessWidget {
  const SwitchBarWidget({
    required this.option,
    Key? key,
  }) : super(key: key);

  final int option;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 361,
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: GestureDetector(
              onTap: () => context
                  .read<NotificationPageBloc>()
                  .add(const NotificationPageSwitchChangedEvent(option: 0)),
              child: Column(
                children: [
                  const SizedBox(height: 2),
                  const SizedBox(
                    width: 180,
                    height: 31,
                    child: Text(
                      'New',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                    thickness: 2,
                    color: option == 0 ? Colors.black : Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 181,
            child: GestureDetector(
              onTap: () => context
                  .read<NotificationPageBloc>()
                  .add(const NotificationPageSwitchChangedEvent(option: 1)),
              child: Column(
                children: [
                  const SizedBox(height: 2),
                  const SizedBox(
                    width: 181,
                    height: 31,
                    child: Text(
                      'Previous',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                    thickness: 2,
                    color: option == 1 ? Colors.black : Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
