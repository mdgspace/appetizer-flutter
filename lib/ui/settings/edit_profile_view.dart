import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/components/appetizer_outline_button.dart';
import 'package:appetizer/ui/components/appetizer_text_field.dart';
import 'package:appetizer/ui/settings/components/user_details_card.dart';
import 'package:appetizer/utils/validators.dart';
import 'package:appetizer/viewmodels/settings/edit_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileView extends StatefulWidget {
  static const String id = 'edit_profile_view';

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final _formKey = GlobalKey<FormState>();

  late String _email, _contactNo;

  @override
  Widget build(BuildContext context) {
    return BaseView<EditProfileViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'Edit Profile'),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: AppTheme.secondary,
                height: 250.h,
                alignment: Alignment.center,
                child: UserDetailsCard(
                  name: model.currentUser!.name,
                  enrollmentNo: model.currentUser!.enrNo.toString(),
                  branch: model.currentUser!.branch,
                  hostel: model.currentUser!.hostelName,
                  roomNo: model.currentUser!.roomNo,
                  email: model.currentUser!.email,
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: AppTheme.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Edit Profile',
                          textAlign: TextAlign.center,
                          style: AppTheme.headline5,
                        ),
                      ),
                      SizedBox(height: 12.r),
                      AppetizerTextField(
                        keyboardType: TextInputType.number,
                        initialValue: model.currentUser!.contactNo,
                        iconData: Icons.phone,
                        label: 'Contact Number',
                        validator: (value) =>
                            !Validators.isPhoneNumberValid(value)
                                ? 'Please enter a valid contact no.'
                                : null,
                        onSaved: (value){
                          if (value != null) _contactNo = value;
                        },
                      ),
                      SizedBox(height: 12.r),
                      AppetizerTextField(
                        keyboardType: TextInputType.emailAddress,
                        initialValue: model.currentUser!.email,
                        iconData: Icons.email,
                        label: 'Email Address',
                        validator: (value) => !Validators.isEmailValid(value)
                            ? 'Please enter a valid e-mail'
                            : null,
                        onSaved: (value){
                          if (value != null) _email = value;
                        }
                      ),
                      SizedBox(height: 24.r),
                      Container(
                        width: double.maxFinite,
                        child: AppetizerOutineButton(
                          title: 'Confirm',
                          onPressed: () async {
                            if (Validators.validateAndSaveForm(_formKey)) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              await model.onConfirmUserDetailsPressed(
                                  _email, _contactNo);
                            }
                          },
                        ),
                      ),
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
}
