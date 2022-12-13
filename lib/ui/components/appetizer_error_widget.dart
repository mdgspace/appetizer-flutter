import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        padding: EdgeInsets.all(6.r),
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
            SizedBox(height: 6.r),
            if (onRetryPressed != null)
              ElevatedButton(
                onPressed: onRetryPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
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
