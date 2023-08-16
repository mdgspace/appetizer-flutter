import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    required this.imageUri,
    Key? key,
  }) : super(key: key);

  final String imageUri;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(const Size(124, 124)),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(62),
            side: const BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 12.4,
            )),
      ),
      width: 124,
      height: 124,
      child: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundImage: AssetImage(
          'lib/assets/images/profile_photo.png',
        ),
      ),
    );
  }
}
