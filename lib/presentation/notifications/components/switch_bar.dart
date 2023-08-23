import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/notifications/bloc/notification_page_bloc.dart';
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
    return Row(
      children: [
        SizedBox(
          width: 180.toAutoScaledWidth,
          child: GestureDetector(
            onTap: () => context
                .read<NotificationPageBloc>()
                .add(const NotificationPageSwitchChangedEvent(option: 0)),
            child: Column(
              children: [
                2.toVerticalSizedBox,
                SizedBox(
                  width: 180.toAutoScaledWidth,
                  height: 31.toAutoScaledHeight,
                  child: Text(
                    'New',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.toAutoScaledFont,
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
          width: 181.toAutoScaledWidth,
          child: GestureDetector(
            onTap: () => context
                .read<NotificationPageBloc>()
                .add(const NotificationPageSwitchChangedEvent(option: 1)),
            child: Column(
              children: [
                2.toVerticalSizedBox,
                SizedBox(
                  width: 181.toAutoScaledWidth,
                  height: 31.toAutoScaledHeight,
                  child: Text(
                    'Previous',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.toAutoScaledFont,
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
    );
  }
}
