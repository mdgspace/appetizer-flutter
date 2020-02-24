import 'package:appetizer/services/multimessing/switch.dart';
import 'package:appetizer/ui/my_switches/see_switch_history.dart';
import 'package:appetizer/ui/my_switches/switch_status_card.dart';
import 'package:flutter/material.dart';

class MySwitches extends StatefulWidget {
  final String token;

  const MySwitches({Key key, this.token}) : super(key: key);

  @override
  _MySwitchesState createState() => _MySwitchesState();
}

class _MySwitchesState extends State<MySwitches> {
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color.fromRGBO(255, 193, 7, 1),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text(
          "My Switches",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getRemainingSwitches(),
                ],
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SeeSwitchHistory(
                        token: widget.token,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getRemainingSwitches() {
    return FutureBuilder(
        future: remainingSwitches(widget.token),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return SwitchStatusCard(null);
          } else {
            return SwitchStatusCard(snapshot.data.count);
          }
        });
  }
}
