import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  const LoginTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.lato(
          fontSize: 12.toAutoScaledFont,
          color: const Color(0xFF111111),
          fontWeight: FontWeight.w600,
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xFF111111).withOpacity(0.25)),
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.toAutoScaledWidth),
      ),
    );
  }
}
