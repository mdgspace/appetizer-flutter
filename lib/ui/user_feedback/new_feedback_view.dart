import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/utils/always_disabled_focus_node.dart';
import 'package:appetizer/utils/feedback_utils.dart';
import 'package:appetizer/utils/validators.dart';
import 'package:appetizer/viewmodels/feedback/new_feedback_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewFeedbackView extends StatefulWidget {
  static const String id = 'new_feedback_view';

  @override
  _NewFeedbackViewState createState() => _NewFeedbackViewState();
}

class _NewFeedbackViewState extends State<NewFeedbackView> {
  final _formKey = GlobalKey<FormState>();

  String _title, _feedbackType = 'gn', description;
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BaseView<NewFeedbackViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(
          title: 'New Feedback',
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.attachment),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if (Validators.validateAndSaveForm(_formKey)) {
                  model.addFeedback(_feedbackType, _title, description, _date);
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Title'),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter Title',
                      hintStyle: TextStyle(color: AppTheme.blackPrimary),
                    ),
                    validator: (value) =>
                        value.isEmpty ? "Title can\'t be empty" : null,
                    onSaved: (value) => _title = value,
                  ),
                  SizedBox(height: 24),
                  Text('Type of Feedback'),
                  DropdownButton<String>(
                    hint: Text(
                      FeedbackUtils.resolveFeedbackTypeCode(_feedbackType),
                      style: TextStyle(color: AppTheme.blackPrimary),
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
                    onChanged: (newValue) =>
                        setState(() => _feedbackType = newValue),
                  ),
                  SizedBox(height: 24),
                  Text('Date'),
                  TextField(
                    focusNode: AlwaysDisabledFocusNode(),
                    decoration: InputDecoration(
                      hintText: DateFormat.yMMMMd().format(_date),
                      hintStyle: TextStyle(color: AppTheme.blackPrimary),
                    ),
                    onTap: () async {
                      final _picked = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101),
                      );
                      if (_picked != null && _picked != _date) {
                        setState(() => _date = _picked.toLocal());
                      }
                    },
                  ),
                  SizedBox(height: 24),
                  Text('Description'),
                  SizedBox(height: 12),
                  TextFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    maxLines: 7,
                    validator: (value) => value.length < 50
                        ? 'Description must be atleast 50 charecters'
                        : null,
                    onSaved: (value) => description = value,
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Image.asset('assets/icons/feedback_dish.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
