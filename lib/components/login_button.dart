import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key, required this.text, required this.onPressed});
  final String text;
  final Function() onPressed;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 110,
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: const Color(0xFFFFC874),
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        style: GoogleFonts.lato(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}