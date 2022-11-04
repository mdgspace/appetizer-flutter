import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class AppetizerPrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AppetizerPrimaryButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        elevation: 0,
        primary: AppTheme.primary,
      ),
      child: Text(
        title,
        style: AppTheme.subtitle1.copyWith(
          fontSize: 20,
          color: AppTheme.white,
        ),
      ),
    );
  }
}
