import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/user/user.dart';
import 'package:flutter/material.dart';

class Fields extends StatelessWidget {
  const Fields({
    required this.title,
    required this.data,
    Key? key,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title ',
          style: TextStyle(
            color: const Color(0xFF111111),
            fontSize: 16.toAutoScaledFont,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          data,
          style: TextStyle(
            color: const Color(0xFF2E2E2E),
            fontSize: 16.toAutoScaledFont,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  final User data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 293.toAutoScaledWidth,
      height: 167.toAutoScaledHeight,
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
          SizedBox(
            height: 8.toAutoScaledHeight,
          ),
          Fields(
            title: 'Hostel:',
            data: data.hostelName,
          ),
          SizedBox(
            height: 8.toAutoScaledHeight,
          ),
          Fields(
            title: 'Branch:',
            data: data.branch ?? "",
          ),
          SizedBox(
            height: 8.toAutoScaledHeight,
          ),
          Fields(
            title: 'Email:',
            data: data.email,
          ),
          SizedBox(
            height: 8.toAutoScaledHeight,
          ),
          Fields(
            title: 'Room No:',
            data: data.roomNo ?? "",
          ),
        ],
      ),
    );
  }
}
