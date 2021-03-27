import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/utils/always_disabled_focus_node.dart';
import 'package:appetizer/utils/date_time_utils.dart';
import 'package:appetizer/utils/feedback_utils.dart';
import 'package:appetizer/viewmodels/feedback/new_feedback_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/colors.dart';

class NewFeedback extends StatefulWidget {
  static const String id = 'new_feedback_view';

  @override
  _NewFeedbackState createState() => _NewFeedbackState();
}

class _NewFeedbackState extends State<NewFeedback> {
  final _formKey = GlobalKey<FormState>();

  String title, feedbackType = 'gn', description;
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BaseView<NewFeedbackViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'New Feedback',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Icon(
                Icons.attachment,
                color: appiYellow,
              ),
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                _validateForm(model);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: Icon(
                  Icons.send,
                  color: appiYellow,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(36),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Title',
                  ),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Enter Title'),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      'Type of Feedback',
                    ),
                  ),
                  DropdownButton<String>(
                    hint: Text(
                      FeedbackUtils.resolveFeedbackTypeCode(feedbackType),
                      style: TextStyle(color: Colors.black),
                    ),
                    items: ['gn', 'am', 'hc', 'tm', 'wm', 'ws', 'dn']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          child: Text(
                            FeedbackUtils.resolveFeedbackTypeCode(value),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        feedbackType = newValue;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      'Date',
                    ),
                  ),
                  Container(
                    child: TextField(
                      focusNode: AlwaysDisabledFocusNode(),
                      decoration: InputDecoration(
                        hintText: date.day.toString() +
                            ' ' +
                            DateTimeUtils.getMonthName(date) +
                            ' ' +
                            date.year.toString(),
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onTap: () => _selectDate(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Text(
                      'Description',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: TextFormField(
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      maxLines: 7,
                      validator: (value) {
                        if (value.length < 50) {
                          return 'Description must be atleast 50 charecters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        description = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Center(
                      child: Image.asset('assets/icons/feedback_dish.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateForm(NewFeedbackViewModel model) {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      model.addFeedback(feedbackType, title, description, date);
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      setState(() {
        date = picked.toLocal();
      });
    }
  }
}
