import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  final String question;
  final String answer;

  const Faq({Key key, this.question, this.answer}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Q.  $question',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 20.0),
              child: Text(
                  'A.  $answer',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: const Color.fromRGBO(0, 0, 0, 0.54),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
