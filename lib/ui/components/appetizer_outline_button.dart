import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppetizerOutineButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AppetizerOutineButton({
    Key key,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 8.r,
          horizontal: 16.r,
        ),
        backgroundColor: Colors.white,
        side: BorderSide(color: AppTheme.primary),
      ),
      child: Text(
        title,
        style: AppTheme.subtitle1.copyWith(
          color: AppTheme.primary,
        ),
      ),
    );
  }
}
