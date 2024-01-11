import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/components/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.obscureText,
    this.suffix,
    this.border,
    required this.title,
    this.maxLength,
    this.maxLines,
    this.titleStyle,
  })  : assert(
          obscureText == null || suffix != null,
          'Suffix should be provided if obscureText is provided',
        ),
        assert(
          controller != null || onChanged != null,
          'Either controller or onChanged should be provided',
        );

  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool? obscureText;
  final Widget? suffix;
  final InputBorder? border;
  final String title;
  final int? maxLength;
  final int? maxLines;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ??
              GoogleFonts.notoSans(
                fontSize: 18.toAutoScaledFont,
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(
          height: title == "Description" ? 0 : 20.toAutoScaledHeight,
        ),
        AppTextField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          hintText: hintText,
          suffix: suffix,
          border: border,
          maxLength: maxLength,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
