import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class AppetizerErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetryPressed;
  final Color textColor;

  const AppetizerErrorWidget({
    Key? key,
    this.errorMessage,
    this.onRetryPressed,
    this.textColor = AppTheme.blackSecondary,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              errorMessage ?? 'Something Wrong Occured !!',
              textAlign: TextAlign.center,
              style: AppTheme.subtitle1.copyWith(
                color: textColor,
              ),
            ),
            SizedBox(height: 8),
            if (onRetryPressed != null)
              ElevatedButton(
                onPressed: onRetryPressed,
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'RETRY',
                  style: AppTheme.bodyText1.copyWith(
                    color: AppTheme.white,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
