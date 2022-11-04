import 'package:flutter/material.dart';

class Validators {
  static final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static bool isEmailValid(String? email){
    if (email == null) return false;
    return _emailRegExp.hasMatch(email);  
  }

  static bool isPhoneNumberValid(String? phoneNumber) {
    if (phoneNumber != null){
      return phoneNumber.length == 10 && int.tryParse(phoneNumber) != null;
    }
    return false;
  }

  static bool validateAndSaveForm(GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    if (form == null) return false;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
