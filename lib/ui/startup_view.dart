import 'package:appetizer/colors.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/startup_viewmodel.dart';
import 'package:flutter/material.dart';

class StartUpView extends StatelessWidget {
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
