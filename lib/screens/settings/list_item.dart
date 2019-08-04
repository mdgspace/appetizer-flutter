import 'package:flutter/material.dart';

class SettingsPageListItems extends StatelessWidget{

  final IconData _iconData;
  final String _title;

  SettingsPageListItems(this._iconData, this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0,12.0,16.0,12.0),
            child: Icon(
              _iconData,
              color: const Color.fromRGBO(252, 193, 21, 1),
              size: 30.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0,12.0,16.0,12.0),
            child: Text(
              "$_title",
              style: TextStyle(
                color: const Color.fromRGBO(94, 94, 94, 1),
                fontSize: 19.0,
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: const Color.fromRGBO(128, 128, 128, 0.5),
              )
          )
      ),
    );
  }
}
