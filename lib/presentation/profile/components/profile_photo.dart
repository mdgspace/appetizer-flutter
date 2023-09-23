import 'package:appetizer/app_theme.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 12.4.toAutoScaledWidth,
          ),
        ),
      ),
      width: 124.toAutoScaledWidth,
      height: 124.toAutoScaledHeight,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.primary.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            context.read<AppBloc>().userName[0],
            style: TextStyle(
              fontSize: 60.toAutoScaledFont,
            ),
          ),
        ),
      ),
      // child: const CircleAvatar(
      //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
      //   foregroundImage: AssetImage(
      //     'assets/images/profile_photo.png',
      //   ),
      // ),
    );
  }
}
