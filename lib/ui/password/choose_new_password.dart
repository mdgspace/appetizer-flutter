import 'package:appetizer/models/user/user.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/viewmodels/password/new_password_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:appetizer/colors.dart';

class ChooseNewPass extends StatefulWidget {
  static const String id = 'choose_new_password_view';
  final User user;

  const ChooseNewPass({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ChooseNewPassState();
}

class _ChooseNewPassState extends State<ChooseNewPass> {
  var formKey = GlobalKey<FormState>();
  String password, email, contactNo;
  final TextEditingController _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<NewPasswordViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: appiYellow,
          ),
          title: Text(
            'Choose New Password',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _choosePassword(),
                    _subTitle(),
                    _showNewPasswordInput(),
                    _showConfirmPasswordInput(),
                    _showEmailInput(),
                    _showContactNoInput(),
                    _showConfirmButton(model),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _choosePassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Hi ',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            widget.user.name.split(' ')[0],
            style: TextStyle(
              color: appiYellow,
              fontSize: 16,
            ),
          ),
          Text(
            ', Choose You Password',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _subTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Text(
        ' Password should be of atleast 8 \n charecters',
        style: TextStyle(
          fontSize: 16,
          color: Colors.red,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _showNewPasswordInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: TextFormField(
        controller: _newPasswordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'New Password',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Password can\'t be empty";
          } else if (value.length < 8) {
            return 'Password is too short';
          }
          return null;
        },
        onSaved: (value) => password = value,
      ),
    );
  }

  Widget _showConfirmPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 0.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Confirm Password',
          icon: Icon(
            Icons.lock,
            color: Colors.grey,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Password can\'t be empty';
          }
          if (value != _newPasswordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
        onSaved: (value) => password = value,
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 0.0),
      child: TextFormField(
        initialValue: widget.user.email,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          icon: Icon(
            Icons.email,
            color: Colors.grey,
          ),
        ),
        validator: (value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          var regex = RegExp(pattern);
          if (!regex.hasMatch(value)) return 'Enter Valid Email';
          return null;
        },
        onSaved: (value) => email = value,
      ),
    );
  }

  Widget _showContactNoInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 48.0, 0.0, 0.0),
      child: TextFormField(
        initialValue: widget.user.contactNo,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Contact No',
          icon: Icon(
            Icons.person,
            color: Colors.grey,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Contact No can\'t be empty";
          } else if (value.length != 10) {
            return 'Please check the entered number';
          }
          return null;
        },
        onSaved: (value) => contactNo = value,
      ),
    );
  }

  Widget _showConfirmButton(NewPasswordViewModel model) {
    return RaisedButton(
      elevation: 5.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appiYellow,
          style: BorderStyle.solid,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(40.0),
      ),
      onPressed: () {
        _validateAndSave(model);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          'CONFIRM',
          style: TextStyle(fontSize: 15.0, color: appiYellow),
        ),
      ),
    );
  }

  void _validateAndSave(NewPasswordViewModel model) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      model.loginUser(widget.user.enrNo, password, email, int.parse(contactNo));
    }
  }
}
