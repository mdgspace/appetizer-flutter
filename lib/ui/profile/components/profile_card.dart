import 'package:appetizer_revamp_parts/models/user/user.dart';
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
          style: const TextStyle(
            color: Color(0xFF111111),
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            color: Color(0xFF2E2E2E),
            fontSize: 16,
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
      width: 293,
      height: 167,
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 37,
        bottom: 20,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
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
          const SizedBox(
            height: 8,
          ),
          Fields(
            title: 'Hostel:',
            data: data.hostelName,
          ),
          const SizedBox(
            height: 8,
          ),
          Fields(
            title: 'Branch:',
            data: data.branch ?? "",
          ),
          const SizedBox(
            height: 8,
          ),
          Fields(
            title: 'Email:',
            data: data.email,
          ),
          const SizedBox(
            height: 8,
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
