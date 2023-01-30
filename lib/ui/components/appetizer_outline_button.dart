import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppetizerOutineButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? theme;
  final TextStyle? textStyle;
  final double? width;

  const AppetizerOutineButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.theme,
    this.textStyle,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: width != null ? 0 : 8.r,
          horizontal: width ?? 16.r,
        ),
        backgroundColor: Colors.white,
        side: BorderSide(
          color: theme ?? AppTheme.primary,
        ),
      ),
      child: Text(
        title,
        style: textStyle?.copyWith(
              color: theme ?? AppTheme.red,
            ) ??
            AppTheme.subtitle1.copyWith(
              color: theme ?? AppTheme.primary,
            ),
      ),
    );
  }
}
