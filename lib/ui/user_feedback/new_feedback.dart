import 'package:appetizer/services/feedback.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appetizer/colors.dart';


class NewFeedback extends StatefulWidget {
  @override
  _NewFeedbackState createState() => _NewFeedbackState();
}

class _NewFeedbackState extends State<NewFeedback> {
  final _formKey = new GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String title, feedbackType = "gn", description;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: const Color.fromRGBO(255, 193, 7, 1),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text(
          "New Feedback",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: new Icon(
              Icons.attachment,
              color: appiYellow,
            ),
          ),
          GestureDetector(
            onTap: _validateForm,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 20),
              child: new Icon(
                Icons.send,
                color: appiYellow,
              ),
            ),
          ),
        ],
        backgroundColor: const Color.fromRGBO(121, 85, 72, 1),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Form(
                key: _formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //new Expanded(child: new Container()),
                    new Text(
                      "Title",
                    ),
                    Container(
                      child: new TextFormField(
                        decoration: InputDecoration(hintText: "Enter Title"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Title can\'t be empty";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          title = value;
                        },
                      ),
                    ),
                    //new Expanded(child: new Container()),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: new Text(
                        "Type of Feedback",
                      ),
                    ),
                    DropdownButton<String>(
                      hint: new Text(
                        resolveFeedbackTypeCode(feedbackType),
                        style: TextStyle(color: Colors.black),
                      ),
                      items: ["gn", "am", "hc", "tm", "wm", "ws", "dn"]
                          .map((String value) {
                        //print(value);
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            child: Text(resolveFeedbackTypeCode(value)),
                          ),
                        );
                      }).toList(),
                      //value: feedbackType,
                      onChanged: (String newValue) {
                        setState(() {
                          feedbackType = newValue;
                        });
                      },
                    ),
                    //new Expanded(child: new Container()),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: new Text(
                        "Date",
                      ),
                    ),
                    Container(
                      child: new TextField(
                        decoration: InputDecoration(
                          hintText: date.day.toString() +
                              " " +
                              DateTimeUtils.getMonthName(date) +
                              " " +
                              date.year.toString(),
                          hintStyle: new TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onTap: () => _selectDate(context),
                      ),
                    ),
                    //new Expanded(child: new Container()),
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: new Text(
                        "Description",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        maxLines: 7,
                        validator: (value) {
                          if (value.length < 50) {
                            return "Description must be atleast 50 charecters";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          description = value;
                        },
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: new Text(
                        "Description must be atleast 50 charecters",
                      ),
                    ),*/
                    //new Expanded(child: new Container()),
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: new Center(
                          child: new Image.asset(
                              "assets/icons/feedback_dish.png")),
                    ),

                    //new Expanded(child: new Container()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      submitFeedback();
    }
  }

  Future submitFeedback() async {
    showCustomDialog(context, "Sending Feedback");
    var prefs = await getUserDetails();
    var response = await newFeedBack(
        prefs.getString("token"), feedbackType, title, description, date);
    print(response);
    await new Future.delayed(new Duration(seconds: 2));
    if (response.id != null) {
      Navigator.pop(context);
      _showSnackBar(context, "Thank You For Your Feedback!");
      await new Future.delayed(new Duration(seconds: 1));
      Navigator.pop(context);
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != date)
      setState(() {
        date = picked.toLocal();
      });
  }

  void _showSnackBar(BuildContext context, String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

Future<SharedPreferences> getUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}
