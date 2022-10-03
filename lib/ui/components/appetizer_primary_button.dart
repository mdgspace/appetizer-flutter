import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppetizerPrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AppetizerPrimaryButton({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 8.r,
          horizontal: 16.r,
        ),
        elevation: 0,
        backgroundColor: AppTheme.primary,
      ),
      child: Text(
        title,
        style: AppTheme.subtitle1.copyWith(
          color: AppTheme.white,
        ),
      ),
    );
  }
}
