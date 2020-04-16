import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/settings/user_details.dart';
import 'package:appetizer/viewmodels/settings_models/edit_profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _formKey = new GlobalKey<FormState>();
  String _email, _contactNo;

  String shareText =
      "Let me recommend you this application:\n https://play.google.com/store/apps/details?id=co.sdslabs.mdg.appetizer&hl=en";

  AppBar _appBar = AppBar(
    title: Text(
      "Edit Profile",
      style: new TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );

  @override
  Widget build(BuildContext context) {
    return BaseView<EditProfileModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    color: appiBrown,
                    child: SafeArea(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        color: appiBrown,
                        alignment: Alignment.topRight,
                        child: SvgPicture.asset(
                          'assets/icons/IITRLogo.svg',
                          height: 160,
                          width: 160,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      _appBar,
                      Container(
                        height: MediaQuery.of(context).size.height / 2 -
                            _appBar.preferredSize.height,
                        alignment: Alignment.center,
                        child: UserDetails(
                          model.currentUser.name,
                          model.currentUser.enrNo.toString(),
                          model.currentUser.branch,
                          model.currentUser.hostelName,
                          model.currentUser.roomNo,
                          model.currentUser.email,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2 -
                    _appBar.preferredSize.height,
                color: Colors.transparent,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Edit Profile",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .primaryTextTheme
                              .display1
                              .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      _showContactNoInput(model),
                      _showEmailInput(model),
                      _showConfirmButton(model),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showConfirmButton(EditProfileModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: OutlineButton(
        highlightedBorderColor: appiYellow,
        borderSide: BorderSide(
          color: appiYellow,
          width: 2,
        ),
        splashColor: Colors.transparent,
        child: ListTile(
          title: Text(
            "Save Details",
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.display1,
          ),
        ),
        onPressed: () {
          _validateAndSave(model);
        },
      ),
    );
  }

  Widget _showContactNoInput(EditProfileModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        initialValue: model.currentUser.contactNo,
        autofocus: false,
        decoration: new InputDecoration(
          labelText: "Contact No",
          labelStyle: Theme.of(context).primaryTextTheme.subhead,
          icon: new Icon(
            Icons.person,
            color: appiGreyIcon,
            size: 30,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return "Contact No can\'t be empty";
          } else if (value.length != 10) {
            return "Please check the entered number";
          }
          return null;
        },
        onSaved: (value) => _contactNo = value,
      ),
    );
  }

  Widget _showEmailInput(EditProfileModel model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        initialValue: model.currentUser.email,
        autofocus: false,
        decoration: new InputDecoration(
          labelText: "Email",
          labelStyle: Theme.of(context).primaryTextTheme.subhead,
          icon: new Icon(
            Icons.mail,
            color: appiGreyIcon,
            size: 30,
          ),
        ),
        validator: (value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(value)) return 'Enter Valid Email';
          return null;
        },
        onSaved: (value) => _email = value,
      ),
    );
  }

  void _validateAndSave(EditProfileModel model) {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      saveDetails(model);
    }
  }

  Future saveDetails(EditProfileModel model) async {
    showCustomDialog(context, "Saving Details");
    await model.updateUserDetails(_email, _contactNo);
    Navigator.pop(context);
  }
}
