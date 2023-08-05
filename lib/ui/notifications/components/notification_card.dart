import 'package:flutter/material.dart';
import 'package:appetizer/models/user/notification.dart' as notification;

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  final notification.Notification data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 127,
      width: 312,
      padding: const EdgeInsets.only(
        top: 15,
        left: 19,
        right: 16,
        bottom: 15,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.71),
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
                  style: const TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 18,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  '${data.dateCreated}',
                  style: const TextStyle(
                    color: Color(0xFF2E2E2E),
                    fontSize: 10,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            data.message,
            style: const TextStyle(
              color: Color(0xFF2E2E2E),
              fontSize: 14,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
