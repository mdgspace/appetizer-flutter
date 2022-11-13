import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppTheme.primary,
        body: Center(
          child: Text(
            'Appetizer',
            textAlign: TextAlign.center,
            style: AppTheme.subtitle1.copyWith(
              fontSize: 36.sp,
              color: AppTheme.white,
              fontFamily: 'Lobster_Two',
            ),
          ),
        ),
      ),
    );
  }
}
