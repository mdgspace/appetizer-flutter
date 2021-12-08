import 'dart:async';

import 'package:appetizer/app_theme.dart';
import 'package:appetizer/models/dialog_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogService {
  Completer _dialogCompleter;

  Completer<DialogResponse> get dialogCompleter => _dialogCompleter;

  void _showDialog(DialogRequest request) {
    Get.dialog(
      SimpleDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppTheme.grey),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
            child: Column(
              children: [
                Icon(
                  request.isFailure
                      ? Icons.warning_amber_outlined
                      : Icons.check_circle_outline,
                  color: request.isFailure ? AppTheme.red : AppTheme.green,
                  size: 72,
                ),
                SizedBox(height: 16),
                Text(
                  request.title,
                  style: AppTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Divider(height: 0),
          GestureDetector(
            onTap: () => dialogComplete(
              DialogResponse(confirmed: true),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                request.buttonTitle,
                style: AppTheme.headline5.copyWith(
                  color: AppTheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(DialogRequest request) {
    Get.dialog(
      SimpleDialog(
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppTheme.grey),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
            child: Column(
              children: [
                Text(
                  request.title,
                  style: AppTheme.headline3,
                  textAlign: TextAlign.center,
                ),
                if (request.description != null) ...[
                  SizedBox(height: 16),
                  Text(
                    request.description,
                    style: AppTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
          Divider(height: 0),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => dialogComplete(
                    DialogResponse(confirmed: false),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      request.cancelTitle,
                      style: AppTheme.headline5.copyWith(
                        color: AppTheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              VerticalDivider(width: 0),
              Expanded(
                child: GestureDetector(
                  onTap: () => dialogComplete(
                    DialogResponse(confirmed: true),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      request.buttonTitle,
                      style: AppTheme.headline5.copyWith(
                        color: AppTheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showProgressDialog(DialogRequest request) {
    Get.dialog(
      SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppTheme.grey),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    request.title,
                    style: AppTheme.headline5,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String buttonTitle = 'Okay',
    bool isFailure = false,
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialog(
      DialogRequest(
        title: title,
        description: description,
        buttonTitle: buttonTitle,
        isFailure: isFailure,
      ),
    );
    return _dialogCompleter.future;
  }

  /// Shows a confirmation dialog
  Future<DialogResponse> showConfirmationDialog({
    String title,
    String description,
    String confirmationTitle = 'YES',
    String cancelTitle = 'NO',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showConfirmationDialog(
      DialogRequest(
        title: title,
        description: description,
        buttonTitle: confirmationTitle,
        cancelTitle: cancelTitle,
      ),
    );
    return _dialogCompleter.future;
  }

  void showCustomProgressDialog({String title}) {
    _showProgressDialog(
      DialogRequest(title: title),
    );
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogResponse response) {
    Get.key.currentState.pop();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }

  void popDialog() {
    if (Get.key.currentState.canPop()) {
      Get.key.currentState.pop();
    }
  }
}
