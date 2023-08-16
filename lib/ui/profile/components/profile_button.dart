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
        width: 115,
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 6),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: Color(0xFFBCBCBC)),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF111111),
            fontSize: 13,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w400,
            height: 1.54,
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
      width: 121,
      height: 36,
      padding: const EdgeInsets.only(top: 4, left: 4, right: 8, bottom: 4),
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
          const SizedBox(
            width: 20,
            height: 20,
            child: Icon(
              Icons.bookmark_border_outlined,
              color: Color.fromARGB(255, 255, 203, 116),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF111111),
              fontSize: 14,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w500,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }
}
