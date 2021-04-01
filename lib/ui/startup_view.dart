import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/startup_viewmodel.dart';
import 'package:flutter/material.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppTheme.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/appetizer_logo.png',
                width: 100,
              ),
              SizedBox(height: 8),
              Image.asset(
                'assets/images/appetizer_text.png',
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
