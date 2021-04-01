import 'package:appetizer/app_theme.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/multimessing/components/switch_confirmation_meal_card.dart';
import 'package:appetizer/viewmodels/switches/confirm_switch_popup_viewmodel.dart';
import 'package:flutter/material.dart';

class ConfirmSwitchPopupView extends StatefulWidget {
  static const String id = 'confirm_switch_popup_view';
  final Meal toMeal;

  const ConfirmSwitchPopupView({
    Key key,
    this.toMeal,
  }) : super(key: key);

  @override
  _ConfirmSwitchPopupViewState createState() => _ConfirmSwitchPopupViewState();
}

class _ConfirmSwitchPopupViewState extends State<ConfirmSwitchPopupView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ConfirmSwitchPopupViewModel>(
      onModelReady: (model) {
        model.toMeal = widget.toMeal;
        model.getMenuWeekMultimessing();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'Confirm Meal Switch'),
        body: () {
          switch (model.state) {
            case ViewState.Idle:
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Switch From',
                            style: AppTheme.headline4,
                          ),
                        ),
                        SwitchConfirmationMealCard(meal: model.fromMeal),
                        GestureDetector(
                          onTap: model.onConfirmSwitchPressed,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/switch_active.png',
                                scale: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Switch To',
                            style: AppTheme.headline4,
                          ),
                        ),
                        SwitchConfirmationMealCard(meal: model.toMeal),
                      ],
                    ),
                  ),
                ),
              );
              break;
            case ViewState.Busy:
              return AppetizerProgressWidget();
              break;
            case ViewState.Error:
              return AppetizerErrorWidget(
                errorMessage: model.errorMessage,
                onRetryPressed: () => model.getMenuWeekMultimessing(),
              );
              break;
            default:
              return Container();
          }
        }(),
      ),
    );
  }
}
