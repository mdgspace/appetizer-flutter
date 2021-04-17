import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class AppetizerProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
      ),
    );
  }
}
