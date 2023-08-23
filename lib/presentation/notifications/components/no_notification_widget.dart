import 'package:flutter/material.dart';

class NoNotificationsWidget extends StatelessWidget {
  const NoNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 282),
      child: const Text(
        'No new notifications !',
        style: TextStyle(
          color: Color(0xFF111111),
          fontSize: 18,
          fontFamily: 'Noto Sans',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
