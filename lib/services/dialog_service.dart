import 'dart:async';

import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:appetizer_revamp_parts/models/dialog_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DialogService {
  Completer<DialogResponse>? _dialogCompleter;

  Completer<DialogResponse> get dialogCompleter => _dialogCompleter!;

  void _showDialog(DialogRequest request) {
    Get.dialog(
      SimpleDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: AppTheme.grey),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 26.r,
              horizontal: 12.r,
            ),
            child: Column(
              children: [
                Icon(
                  request.isFailure!
                      ? Icons.warning_amber_outlined
                      : Icons.check_circle_outline,
                  color: request.isFailure! ? AppTheme.red : AppTheme.green,
                  size: 60.r,
                ),
                SizedBox(height: 12.r),
                Text(
                  request.title,
                  style: AppTheme.headline1,
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
              padding: EdgeInsets.symmetric(vertical: 12.r),
              child: Text(
                request.buttonTitle!,
                style: AppTheme.headline1.copyWith(
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
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
          side: BorderSide(color: AppTheme.grey),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24.r,
              horizontal: 12.r,
            ),
            child: Column(
              children: [
                Text(
                  request.title,
                  style: AppTheme.headline1,
                  textAlign: TextAlign.center,
                ),
                if (request.description != null) ...[
                  SizedBox(height: 12.r),
                  Text(
                    request.description!,
                    style: AppTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ]
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
                    padding: EdgeInsets.symmetric(vertical: 12.r),
                    child: Text(
                      request.cancelTitle!,
                      style: AppTheme.headline1.copyWith(
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
                    padding: EdgeInsets.symmetric(vertical: 12.r),
                    child: Text(
                      request.buttonTitle!,
                      style: AppTheme.headline1.copyWith(
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
    ).then((_) {
      if (_dialogCompleter == null) return;

      // Dialog is canceled by User
      dialogComplete(
        DialogResponse(confirmed: false),
        shouldPop: false,
      );
    });
  }

  void _showProgressDialog(DialogRequest request) {
    Get.dialog(
      SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: AppTheme.grey),
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 16.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: 12.r),
                Expanded(
                  child: Text(
                    request.title,
                    style: AppTheme.headline1,
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
    required String title,
    required String description,
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
    return _dialogCompleter!.future;
  }

  /// Shows a confirmation dialog
  Future<DialogResponse> showConfirmationDialog({
    required String title,
    required String description,
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
    return _dialogCompleter!.future;
  }

  void showCustomProgressDialog({required String title}) {
    _showProgressDialog(
      DialogRequest(title: title),
    );
  }

  /// Completes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogResponse response, {bool shouldPop = true}) {
    // If dialog is not canceled by user
    if (shouldPop) Get.key.currentState!.pop();
    _dialogCompleter!.complete(response);
    _dialogCompleter = null;
  }

  void popDialog() {
    if (Get.key.currentState!.canPop()) {
      Get.key.currentState!.pop();
    }
  }
}
