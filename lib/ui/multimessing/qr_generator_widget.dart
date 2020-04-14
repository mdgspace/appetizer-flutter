import 'dart:ui';

import 'package:appetizer/colors.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/multimessing_models/qr_genrator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRWidget extends StatefulWidget {
  final int switchId;

  const QRWidget({Key key, this.switchId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => QRWidgetState();
}

class QRWidgetState extends State<QRWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseView<QRGeneratorModel>(
      onModelReady: (model) => model.fetchSecretCode(widget.switchId),
      builder: (context, model, child) => model.state != ViewState.Idle
          ? Container(
              height: 150,
              child: Center(
                child: model.state == ViewState.Busy
                    ? CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(appiYellow),
                      )
                    : Text("No Secret was fetched"),
              ),
            )
          : _contentWidget(model.secretCode),
    );
  }

  _contentWidget(String secretCode) {
    return secretCode == null
        ? Container(
            height: 150,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  "QR code not availaible right now. Check out later!",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        : Padding(
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
