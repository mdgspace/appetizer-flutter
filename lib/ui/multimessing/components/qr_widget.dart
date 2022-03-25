import 'package:appetizer/app_theme.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/viewmodels/multimessing/qr_genrator_viewmodel.dart';
import 'package:flutter/material.dart';
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
    return BaseView<QRGeneratorViewModel>(
      onModelReady: (model) => model.fetchSecretCode(widget.switchId),
      builder: (context, model, child) => () {
        switch (model.state) {
          case ViewState.Idle:
            if (model.secretCode == null) {
              return Container(
                height: 150,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'QR code not availaible right now. Check out later!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Container(
                  color: AppTheme.white,
                  child: QrImage(
                    data: model.secretCode,
                    size: 150,
                  ),
                ),
              ),
            );

          case ViewState.Busy:
            return AppetizerProgressWidget();

          case ViewState.Error:
            return Text('No Secret was fetched');

          default:
            return Container();
        }
      }(),
    );
  }
}
