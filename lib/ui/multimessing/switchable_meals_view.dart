import 'package:appetizer/app_theme.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/multimessing/switchable_meal.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/viewmodels/multimessing/switchable_meals_viewmodel.dart';
import 'package:flutter/material.dart';

class SwitchableMealsView extends StatefulWidget {
  static const String id = 'switchable_meals_view';
  final int mealId;

  const SwitchableMealsView({Key key, this.mealId}) : super(key: key);

  @override
  _SwitchableMealsState createState() => _SwitchableMealsState();
}

class _SwitchableMealsState extends State<SwitchableMealsView> {
  SwitchableMealsViewModel _model;

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: AppTheme.secondary),
      children: [
        TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'BHAWAN',
                    style: AppTheme.headline4.copyWith(
                      color: AppTheme.primary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'MENU',
                  style: AppTheme.headline4.copyWith(
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  TableRow _buildTableRow(SwitchableMeal _switchableMealsFromYourMeal) {
    return TableRow(
      children: [
        TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: Text(
                    '${_switchableMealsFromYourMeal.hostelName}',
                    style: AppTheme.headline4.copyWith(
                      color: AppTheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Column(
                children: _switchableMealsFromYourMeal.items
                    .map((item) => Text('${item.name}'))
                    .toList(),
              ),
              GestureDetector(
                onTap: () => _model.onSwitchTapped(
                    widget.mealId, _switchableMealsFromYourMeal.hostelName),
                child: Image.asset(
                  'assets/icons/switch_active.png',
                  width: 30,
                  scale: 2,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SwitchableMealsViewModel>(
      onModelReady: (model) {
        _model = model;
        _model.getSwitchableMeals(widget.mealId);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Mess Menu',
            style: AppTheme.headline1.copyWith(
              color: AppTheme.white,
              fontFamily: 'Lobster_Two',
            ),
          ),
        ),
        body: () {
          switch (model.state) {
            case ViewState.Idle:
              return Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(
                  width: 0.5,
                  color: AppTheme.lightGrey,
                ),
                children: <TableRow>[
                  _buildTableHeader(),
                  ...model.listOfSwitchableMeals
                      .map((meal) => _buildTableRow(meal))
                ],
              );
              break;
            case ViewState.Busy:
              return AppetizerProgressWidget();
              break;
            case ViewState.Error:
              return AppetizerErrorWidget(
                errorMessage: model.errorMessage,
                onRetryPressed: () => model.getSwitchableMeals(widget.mealId),
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
