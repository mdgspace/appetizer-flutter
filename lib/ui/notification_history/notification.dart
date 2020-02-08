import 'package:flutter/material.dart';

class MessNotification extends StatefulWidget{

  final String _heading;
  final String _message;
  final String _dateAndTime;

  MessNotification(this._heading, this._message, this._dateAndTime);

  @override
  _MessNotificationState createState() => _MessNotificationState();
}

class _MessNotificationState extends State<MessNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: const Color.fromRGBO(0, 0, 0, 0.15),
              )
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                '${widget._heading}',
                style: TextStyle(
                  fontSize: 19.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 2.0),
              child: Text(
                  '${widget._message}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: const Color.fromRGBO(0, 0, 0, 0.54),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                '${widget._dateAndTime}',
                style: TextStyle(
                  color: const Color.fromRGBO(0, 0, 0, 0.54),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
