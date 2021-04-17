import 'package:appetizer/app_theme.dart';
import 'package:appetizer/models/menu/week_menu.dart';
import 'package:appetizer/utils/menu_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SwitchConfirmationMealCard extends StatefulWidget {
  final Meal meal;

  const SwitchConfirmationMealCard({Key key, this.meal}) : super(key: key);

  @override
  _SwitchConfirmationMealCardState createState() =>
      _SwitchConfirmationMealCardState();
}

class _SwitchConfirmationMealCardState
    extends State<SwitchConfirmationMealCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${widget.meal.title}',
                        style: AppTheme.headline1.copyWith(
                          color: AppTheme.primary,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd()
                            .format(widget.meal.startDateTime),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  MenuUIUtils.buildMealItemsComponent(widget.meal)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
