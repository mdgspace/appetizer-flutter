import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppetizerPrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? theme;
  final TextStyle? textStyle;
  final double? width;

  const AppetizerPrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.theme,
    this.textStyle,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: width != null ? 0 : 8.r,
          horizontal: width ?? 16.r,
        ),
        elevation: 0,
        backgroundColor: theme ?? AppTheme.primary,
      ),
      child: Text(
        title,
        style: textStyle?.copyWith(color: AppTheme.white) ??
            AppTheme.subtitle1.copyWith(
              color: AppTheme.white,
            ),
      ),
    );
  }
}
