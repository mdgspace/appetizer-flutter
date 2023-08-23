import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
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
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(62.toAutoScaledWidth),
            side: BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 12.4.toAutoScaledWidth,
            )),
      ),
      width: 124.toAutoScaledWidth,
      height: 124.toAutoScaledHeight,
      child: const CircleAvatar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundImage: AssetImage(
          'assets/images/profile_photo.png',
        ),
      ),
    );
  }
}
