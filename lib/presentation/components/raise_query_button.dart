import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RaiseQueryButton extends StatelessWidget {
  const RaiseQueryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        const snackBar =
            SnackBar(content: Text('Contact us at mdg@iitr.ac.in'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        'Raise a Query',
        style: GoogleFonts.inter(
          color: const Color(0xFF008BFF),
          fontSize: 12.toAutoScaledFont,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
