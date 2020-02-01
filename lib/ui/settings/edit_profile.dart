import 'package:appetizer/ui/settings/settings_screen.dart';
import 'package:appetizer/ui/settings/user_details.dart';
import 'package:appetizer/services/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appetizer/colors.dart';
import 'package:appetizer/ui/components/alert_dialog.dart';

class EditProfile extends StatefulWidget {
  final String contactNo;
  final String email;

  const EditProfile({Key key, this.contactNo, this.email}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var formKey = new GlobalKey<FormState>();

  SharedPreferences prefs;
  String shareText =
      "Let me recommend you this application:\n https://play.google.com/store/apps/details?id=co.sdslabs.mdg.appetizer&hl=en";
  String name, branch, hostel, room, email, enr, contactNo, token;
  double width;

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  Future getUserDetails() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString("token");
      name = prefs.getString("username");
      enr = prefs.getString("enrNo");
      branch = prefs.getString("branch");
      hostel = prefs.getString("hostelName");
      room = prefs.getString("roomNo");
      email = prefs.getString("email");
      contactNo = prefs.getString("contactNo");
    });
    print(name);
    print(enr.toString());
    print(branch);
    print(hostel);
    print(room);
    print(email);
    print(contactNo.toString());
  }

  Future<void> saveUserDetails(String contactNo, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("contactNo", contactNo);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(121, 85, 72, 1),
        ),
        SafeArea(
          child: Container(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/icons/IITRLogo.svg',
              height: 160,
              width: 160,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: const Color.fromRGBO(255, 193, 7, 1),
              onPressed: () => Navigator.pop(context, false),
            ),
//            actions: <Widget>[
//              GestureDetector(
//                child: new Text(
//                  "SAVE",
//                  style: TextStyle(
//                    fontSize: 12,
//                  ),
//                ),
//              ),
//            ],
            title: Text(
              "Settings",
              style: new TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        child: UserDetails(name, enr, branch, hostel, room, email)),
//                      Container(
//                        color: Colors.transparent,
//                        child:
//                            UserDetails(name, enr, branch, hostel, room, email),
//                      ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 1.9,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16,16,16,16),
                            child: Text("Edit Profile",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .display1
                                    .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500)),
                          ),
                          _showContactNoInput(),
                          _showEmailInput(),
                          _showConfirmButton(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _showConfirmButton() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(24, 50, 24, 24),
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
          onPressed: _validateAndSave,
        ));
  }

  Widget _showContactNoInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        initialValue: widget.contactNo,
        autofocus: false,
        decoration: new InputDecoration(
          labelText: "Contact No",
          labelStyle:
          Theme.of(context).primaryTextTheme.subhead,
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
        onSaved: (value) => contactNo = value,
      ),
    );
  }

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 20.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        initialValue: widget.email,
        autofocus: false,
        decoration: new InputDecoration(
          labelText: "Email",
          labelStyle:
          Theme.of(context).primaryTextTheme.subhead,
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
        onSaved: (value) => email = value,
      ),
    );
  }

  void _validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      saveDetails();
    }
  }

  Future saveDetails() async {
    showCustomDialog(context, "Saving Details");
    var response = await userMePatch(token, email, contactNo);
    Navigator.pop(context);
    //_showSnackBar(context, "Details have been updated successfully");
    //new Future.delayed(new Duration(seconds: 3));
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Settings()));

    saveUserDetails(contactNo, email);
  }

  void _showSnackBar(BuildContext context, String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
