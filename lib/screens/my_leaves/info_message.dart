import 'package:flutter/material.dart';

class InfoMessage extends StatelessWidget{

  final String _message;

  InfoMessage(this._message);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(242, 242, 242, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 2.0, 4.0, 2.0),
            child: Icon(
              Icons.info,
              color: const Color.fromRGBO(103, 103, 103, 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 2.0, 2.0, 2.0),
            child: Text(
              '$_message',
              style: TextStyle(
                color: const Color.fromRGBO(00, 00, 00, 0.54),
              ),
            ),
          )
        ],
      ),
    );
  }
}
