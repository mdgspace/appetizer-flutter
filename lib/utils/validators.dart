import 'package:flutter/material.dart';

class Validators {
  static final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static bool isEmailValid(String email) => _emailRegExp.hasMatch(email);

  static bool isPhoneNumberValid(String phoneNumber) {
    return (phoneNumber?.length ?? 0) == 10 && int.tryParse(phoneNumber) != null
        ? true
        : false;
  }

  static bool validateAndSaveForm(GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
