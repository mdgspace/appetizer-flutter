import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/domain/models/user/notification.dart' as notification;

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  final notification.Notification data;

  @override
  Widget build(BuildContext context) {
    String date = DateTimeUtils.dateTimeWithoutSeconds(data.dateCreated);
    return Container(
      height: 127.toAutoScaledHeight,
      width: 312.toAutoScaledWidth,
      padding: EdgeInsets.only(
        top: 15.toAutoScaledHeight,
        left: 19.toAutoScaledWidth,
        right: 16.toAutoScaledWidth,
        bottom: 15.toAutoScaledHeight,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.71.toAutoScaledWidth),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 16,
            offset: Offset(0, 0),
            spreadRadius: 1.07,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data.title,
                  style: TextStyle(
                    color: const Color(0xFF111111),
                    fontSize: 18.toAutoScaledFont,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  date,
                  style: TextStyle(
                    color: const Color(0xFF2E2E2E),
                    fontSize: 10.toAutoScaledFont,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          4.toVerticalSizedBox,
          Text(
            data.message,
            style: TextStyle(
              color: const Color(0xFF2E2E2E),
              fontSize: 14.toAutoScaledFont,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
