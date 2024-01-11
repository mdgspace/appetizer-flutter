import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.obscureText,
    this.suffix,
    this.border,
    this.maxLength,
    this.maxLines,
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
  final int? maxLength;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.lato(
            fontSize: 12.toAutoScaledFont,
            color: const Color(0xFF111111),
            fontWeight: FontWeight.w600,
          ),
          border: border ??
              OutlineInputBorder(
                borderSide: BorderSide(
                    color: const Color(0xFF111111).withOpacity(0.25)),
                borderRadius: BorderRadius.circular(5),
              ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20.toAutoScaledWidth,
              vertical: 15.toAutoScaledHeight),
          suffixIcon: suffix),
      maxLength: maxLength,
      maxLines: maxLines ?? 1,
    );
  }
}
