import 'package:appetizer/colors.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/models/dialog_models.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:flutter/material.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogRequest request) {
    var isConfirmationDialog = request.cancelTitle != null;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          request.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(request.description),
        actions: <Widget>[
          if (isConfirmationDialog)
            FlatButton(
              child: Text(
                request.cancelTitle,
                style: TextStyle(
                  color: appiYellow,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                _dialogService.dialogComplete(
                  DialogResponse(confirmed: false),
                );
              },
            ),
          FlatButton(
            child: Text(
              request.buttonTitle,
              style: TextStyle(
                color: appiYellow,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              _dialogService.dialogComplete(
                DialogResponse(confirmed: true),
              );
            },
          ),
        ],
      ),
    );
  }
}
