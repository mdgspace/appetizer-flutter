import 'package:appetizer/change_notifiers/menu_model.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/models/multimessing/meal_switch_from_your_meals.dart';
import 'package:appetizer/services/multimessing/list_switchable_meals.dart';
import 'package:appetizer/services/multimessing/switch_meals.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/ui/multimessing/confirmed_switch_screen.dart';
import 'package:appetizer/utils/get_hostel_code.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SwitchableMealsScreen extends StatefulWidget {
  final String token;
  final int id;

  const SwitchableMealsScreen({
    Key key,
    this.token,
    this.id,
  }) : super(key: key);

  @override
  _SwitchableMealsuitate createState() => _SwitchableMealsuitate();
}

class _SwitchableMealsuitate extends State<SwitchableMealsScreen> {
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
                    "BHAWAN",
                    style: getHeaderTextStyle(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "MENU",
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
    List<Widget> _itemsWidgetList = [];
    items.forEach((item) {
      _itemsWidgetList.add(Text('${item.name}'));
    });
    return Column(
      children: _itemsWidgetList,
    );
  }

  List<TableRow> _tableBody(
      List<SwitchableMealsForYourMeal> listOfSwitchableMealsForYourMeal) {
    List<TableRow> _body = [];
    _body.add(_tableHeader());
    listOfSwitchableMealsForYourMeal.forEach((meal) {
      _body.add(_getTableRow(meal));
    });
    return _body;
  }

  TableRow _getTableRow(
      SwitchableMealsForYourMeal _switchableMealsFromYourMeal) {
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
                child: Image.asset(
                  "assets/icons/switch_active.png",
                  width: 30,
                  scale: 2,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext alertContext) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        title: new Text(
                          "Confirm Switch",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: new Text(
                          "Are you sure you want to switch this meal?",
                        ),
                        actions: <Widget>[
                          new FlatButton(
                            onPressed: () {
                              Navigator.pop(alertContext);
                            },
                            child: new Text(
                              "CANCEL",
                              style: TextStyle(
                                  color: appiYellow,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          new FlatButton(
                            child: new Text(
                              "SWITCH",
                              style: TextStyle(
                                  color: appiYellow,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              Navigator.pop(alertContext);
                              showCustomDialog(context, "Switching Meals");
                              switchMeals(
                                widget.id,
                                hostelCodeMap[
                                    _switchableMealsFromYourMeal.hostelName],
                                widget.token,
                              ).then(
                                (switchResponse) {
                                  if (switchResponse == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ConfirmedSwitchScreen(),
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Cannot switch meals");
                                  }
                                },
                              );
                            },
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => MenuModel(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Mess Menu",
            style: new TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontFamily: 'Lobster_Two',
            ),
          ),
        ),
        backgroundColor: appiBrown,
        iconTheme: new IconThemeData(color: appiYellow),
      ),
      body: FutureBuilder(
        future: listSwitchableMeals(widget.id, widget.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(appiYellow),

                ),
              );
            } else {
              var data = snapshot.data;
              return Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(
                  width: 0.5,
                  color: appiGrey.withOpacity(0.5),
                ),
                children: _tableBody(data),
              );
            }
          },
        ),
      ),
    );
  }
}
