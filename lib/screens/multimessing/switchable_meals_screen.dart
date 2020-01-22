import 'package:appetizer/colors.dart';
import 'package:appetizer/screens/menu_screens/week_menu_screen.dart';
import 'package:appetizer/services/multimessing/list_switchable_meals.dart';
import 'package:flutter/material.dart';

class SwitchableMealsScreen extends StatefulWidget {
  final String token;
  final int id;

  const SwitchableMealsScreen({Key key, this.token, this.id}) : super(key: key);

  @override
  _SwitchableMealsScreenState createState() => _SwitchableMealsScreenState();
}

class _SwitchableMealsScreenState extends State<SwitchableMealsScreen> {
  TextStyle getHeaderTextStyle() {
    return TextStyle(color: appiYellow, fontSize: 18);
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _tableHeader() {
    return Table(
      border: TableBorder.all(
        width: 0.2,
        color: appiGrey.withOpacity(0.5),
      ),
      children: [
        TableRow(
          children: [
            TableCell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "BHAWAN",
                      style: getHeaderTextStyle(),
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/icons/week_menu.png"),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeekMenu(widget.token),
                  ),
                );
              },
            ),
          )
        ],
        backgroundColor: appiBrown,
        iconTheme: new IconThemeData(color: appiYellow),
      ),
      body: FutureBuilder(
        future: listSwitchableMeals(widget.id, widget.token),
        builder: (context, snapshot){
//          if(snapshot.connectionState == ConnectionState.waiting){
//            return Container(
//              height: MediaQuery.of(context).size.height / 1.5,
//              width: MediaQuery.of(context).size.width,
//              child: Center(
//                child: CircularProgressIndicator(
//                  valueColor: AlwaysStoppedAnimation<Color>(appiYellow),
//                ),
//              ),
//            );
//          }else{
//            return
//          }
        },
      ),
    );
  }
}
