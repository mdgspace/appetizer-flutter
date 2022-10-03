import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppetizerTextField extends StatelessWidget {
  final String initialValue;
  final num maxLines;
  final String label;
  final IconData iconData;
  final Function(String) onChanged;
  final Function(String) validator;
  final Function(String) onSaved;
  final TextInputType keyboardType;

  const AppetizerTextField({
    Key key,
    this.initialValue,
    this.maxLines = 1,
    @required this.label,
    this.iconData,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: AppTheme.subtitle2,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTheme.subtitle2,
        icon: Icon(
          iconData,
          color: AppTheme.blackSecondary,
          size: 18.r,
        ),
      ),
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
