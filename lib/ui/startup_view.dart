import 'package:appetizer/colors.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/startup_view_model.dart';
import 'package:flutter/material.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: appiYellow,
      ),
    );
  }
}
