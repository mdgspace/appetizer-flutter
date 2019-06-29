import 'package:flutter/material.dart';

import '../../colors.dart';
import 'faq.dart';
import 'package:appetizer/services/transaction.dart';

class FaqList extends StatelessWidget {
  final String token;

  const FaqList({Key key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: const Color.fromRGBO(255, 193, 7, 1),
            onPressed: () => Navigator.pop(context, false),
          ),
          title: Text(
            "FAQs",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
        ),
        body: faqs());
  }

  Widget faqs() {
    return FutureBuilder(
        future: getFAQ(token),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(appiYellow),
              )),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Faq(
                    question: snapshot.data[index].question,
                    answer: snapshot.data[index].answer,
                  );
                });
          }
        });
  }
}
