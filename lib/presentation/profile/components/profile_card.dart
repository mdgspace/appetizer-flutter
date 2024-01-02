import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fields extends StatelessWidget {
  const Fields({
    required this.title,
    required this.data,
    super.key,
  });

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '$title ',
          style: GoogleFonts.lato(
            color: const Color(0xFF111111),
            fontSize: 16.toAutoScaledFont,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          data,
          style: GoogleFonts.inter(
            color: const Color(0xFF2E2E2E),
            fontSize: 16.toAutoScaledFont,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({required this.data, super.key});

  final User data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.toAutoScaledHeight,
        left: 20.toAutoScaledWidth,
        right: 37.toAutoScaledWidth,
        bottom: 20.toAutoScaledHeight,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.toAutoScaledWidth),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 16,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Fields(
            title: 'Enrollment No:',
            data: '${data.enrNo}',
          ),
          8.toVerticalSizedBox,
          Fields(
            title: 'Hostel:',
            data: data.hostelName,
          ),
          8.toVerticalSizedBox,
          Fields(
            title: 'Branch:',
            data: data.branch ?? "",
          ),
          8.toVerticalSizedBox,
          Fields(
            title: 'Email:',
            data: data.email,
          ),
          8.toVerticalSizedBox,
          Fields(
            title: 'Room No:',
            data: data.roomNo ?? "",
          ),
        ],
      ),
    );
  }
}
