import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppetizerPasswordField extends StatefulWidget {
  final String label;
  final IconData iconData;
  final Function(String)? onChanged;
  final String? Function(String?) validator;
  final String? Function(String?)? onSaved;

  const AppetizerPasswordField({
    Key? key,
    required this.label,
    required this.iconData,
    this.onChanged,
    required this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  _AppetizerPasswordFieldState createState() => _AppetizerPasswordFieldState();
}

class _AppetizerPasswordFieldState extends State<AppetizerPasswordField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      style: AppTheme.subtitle2,
      decoration: InputDecoration(
        icon: Icon(
          widget.iconData,
          color: AppTheme.blackSecondary,
          size: 18.r,
        ),
        suffixIcon: GestureDetector(
          onTap: _toggle,
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppTheme.blackSecondary,
            size: 18.r,
          ),
        ),
        labelText: widget.label,
        labelStyle: AppTheme.subtitle2,
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}
