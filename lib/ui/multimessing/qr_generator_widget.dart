import 'dart:ui';

import 'package:appetizer/colors.dart';
import 'package:appetizer/services/multimessing/switch_meals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRWidget extends StatefulWidget {
  final String token;
  final int switchId;

  const QRWidget({Key key, this.token, this.switchId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => QRWidgetState();
}

class QRWidgetState extends State<QRWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSwitchDetails(widget.switchId, widget.token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 150,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(appiYellow),
              ),
            ),
          );
        } else if (snapshot.data != null) {
          return _contentWidget(snapshot.data.secretCode);
        } else {
          Fluttertoast.showToast(msg: "No Secret was fetched");
          return Container();
        }
      },
    );
  }

  _contentWidget(String secretCode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Container(
          color: const Color(0xFFFFFFFF),
          child: QrImage(
            data: secretCode,
            version: QrVersions.auto,
            size: 150,
            gapless: false,
          ),
        ),
      ),
    );
  }
}
