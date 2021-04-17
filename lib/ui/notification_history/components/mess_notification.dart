import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class MessNotification extends StatefulWidget {
  final String heading;
  final String message;
  final String dateAndTime;

  MessNotification(this.heading, this.message, this.dateAndTime);

  @override
  _MessNotificationState createState() => _MessNotificationState();
}

class _MessNotificationState extends State<MessNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.heading}',
              style: AppTheme.headline4.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${widget.message}',
              style: AppTheme.subtitle1,
            ),
            SizedBox(height: 4),
            Text(
              '${widget.dateAndTime}',
              style: AppTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
