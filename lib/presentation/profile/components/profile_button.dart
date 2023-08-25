import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';

class ProfileTextButton extends StatelessWidget {
  const ProfileTextButton(
      {required this.title, required this.onPressed, Key? key})
      : super(key: key);

  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: 115.toAutoScaledWidth,
        height: 32.toAutoScaledHeight,
        padding: EdgeInsets.symmetric(
            horizontal: 26.toAutoScaledWidth, vertical: 6.toAutoScaledHeight),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: Color(0xFFBCBCBC)),
            borderRadius: BorderRadius.circular(6.toAutoScaledWidth),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 13.toAutoScaledFont,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            height: 1.54.toAutoScaledHeight,
          ),
        ),
      ),
    );
  }
}

class ProfileIconButton extends StatelessWidget {
  const ProfileIconButton({
    required this.title,
    required this.onPressed,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final String title;
  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 121.toAutoScaledWidth,
      height: 36.toAutoScaledHeight,
      padding: EdgeInsets.only(
          top: 4.toAutoScaledHeight,
          left: 4.toAutoScaledWidth,
          right: 8.toAutoScaledWidth,
          bottom: 4.toAutoScaledHeight),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 7,
            offset: Offset(2, 2),
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.toAutoScaledWidth,
            height: 20.toAutoScaledHeight,
            child: Icon(
              Icons.bookmark_border_outlined,
              color: Color.fromARGB(255, 255, 203, 116),
            ),
          ),
          SizedBox(width: 10.toAutoScaledWidth),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF111111),
              fontSize: 14.toAutoScaledFont,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w500,
              height: 1.43.toAutoScaledHeight,
            ),
          ),
        ],
      ),
    );
  }
}
