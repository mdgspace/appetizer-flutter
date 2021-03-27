import 'package:appetizer/colors.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/models/multimessing/switchable_meal.dart';
import 'package:appetizer/services/dialog_service.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/menu_screens/week_menu_screen.dart';
import 'package:appetizer/ui/multimessing/confirmed_switch_screen.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:appetizer/viewmodels/multimessing/switchable_meals_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SwitchableMealsScreen extends StatefulWidget {
  static const String id = 'on_boarding';
  final int mealId;

  const SwitchableMealsScreen({Key key, this.mealId}) : super(key: key);

  @override
  _SwitchableMealsState createState() => _SwitchableMealsState();
}

class _SwitchableMealsState extends State<SwitchableMealsScreen> {
  TextStyle getHeaderTextStyle() {
    return TextStyle(color: appiYellow, fontSize: 18);
  }

  TableRow _tableHeader() {
    return TableRow(
      children: [
        TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    'BHAWAN',
                    style: getHeaderTextStyle(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'MENU',
                  style: getHeaderTextStyle(),
                ),
              ),
            ],
          ),
        )
      ],
      decoration: BoxDecoration(
        color: appiBrown,
      ),
    );
  }

  Widget _getItemsWidget(List<Item> items) {
    var _itemsWidgetList = <Widget>[];
    items.forEach((item) {
      _itemsWidgetList.add(Text('${item.name}'));
    });
    return Column(
      children: _itemsWidgetList,
    );
  }

  List<TableRow> _tableBody(
      List<SwitchableMeal> listOfSwitchableMealsForYourMeal,
      SwitchableMealsViewModel model) {
    var _body = <TableRow>[];
    _body.add(_tableHeader());
    listOfSwitchableMealsForYourMeal.forEach((meal) {
      _body.add(_getTableRow(meal, model));
    });
    return _body;
  }

  TableRow _getTableRow(SwitchableMeal _switchableMealsFromYourMeal,
      SwitchableMealsViewModel model) {
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
                    horizontal: 18,
                  ),
                  child: Text(
                    '${_switchableMealsFromYourMeal.hostelName}',
                    style: getHeaderTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              _getItemsWidget(_switchableMealsFromYourMeal.items),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext alertContext) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        title: Text(
                          'Confirm Switch',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          'Are you sure you want to switch this meal?',
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(alertContext);
                            },
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                  color: appiYellow,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                              Navigator.pop(alertContext);
                              DialogService().showCustomProgressDialog(
                                  title: 'Switching Meals');
                              await model.switchMeals(
                                widget.mealId,
                                hostelCodeMap[
                                    _switchableMealsFromYourMeal.hostelName],
                              );
                              // if (widget.model == 0) {
                              //   Provider.of<YourMenuModel>(context,
                              //           listen: false)
                              //       .selectedWeekMenuYourMeals(widget.weekId);
                              // } else {
                              //   Provider.of<OtherMenuModel>(context,
                              //           listen: false)
                              //       .getOtherMenu(widget.weekId);
                              // }
                              if (model.isMealSwitched) {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConfirmedSwitchScreen(),
                                  ),
                                );
                              }
                              if (model.state == ViewState.Error) {
                                Navigator.pop(context);
                                await Fluttertoast.showToast(
                                  msg: model.errorMessage,
                                );
                              }
                            },
                            child: Text(
                              'SWITCH',
                              style: TextStyle(
                                  color: appiYellow,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
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
      onModelReady: (model) => model.getSwitchableMeals(widget.mealId),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Mess Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontFamily: 'Lobster_Two',
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeekMenu(),
                    ),
                  );
                },
                child: Container(
                  child: Image.asset('assets/icons/week_menu.png'),
                ),
              ),
            )
          ],
          iconTheme: IconThemeData(color: appiYellow),
        ),
        body: model.state == ViewState.Busy
            ? AppetizerProgressWidget()
            : model.state == ViewState.Error
                ? AppetizerErrorWidget(errorMessage: model.errorMessage)
                : Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(
                      width: 0.5,
                      color: appiGrey.withOpacity(0.5),
                    ),
                    children: _tableBody(model.listOfSwitchableMeals, model),
                  ),
      ),
    );
  }
}
