import 'package:appetizer_revamp_parts/app_theme.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary));
  }
}
