import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/components/app_banner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternetBanner extends StatelessWidget {
  const NoInternetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBanner(
      height: 140.toAutoScaledHeight,
      child: Row(
        children: [
          SizedBox(
            width: 12.toAutoScaledWidth,
          ),
          Text(
            'Appetizer',
            style: GoogleFonts.notoSans(
              color: Colors.white,
              fontSize: 24.toAutoScaledWidth,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
