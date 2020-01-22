import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRWidget extends StatefulWidget {
  final String secretCode;

  const QRWidget({Key key, this.secretCode}) : super(key: key);

  @override
  State<StatefulWidget> createState() => QRWidgetState();
}

class QRWidgetState extends State<QRWidget> {
  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _contentWidget();
  }

  _contentWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Container(
          color: const Color(0xFFFFFFFF),
          child: QrImage(
            data: widget.secretCode,
            version: QrVersions.auto,
            size: 150,
            gapless: false,
          ),
        ),
      ),
    );
  }
}
