import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class AppetizerOutineButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AppetizerOutineButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        primary: Colors.white,
        side: BorderSide(color: AppTheme.primary),
      ),
      child: Text(
        title,
        style: AppTheme.subtitle1.copyWith(
          fontSize: 20,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}
