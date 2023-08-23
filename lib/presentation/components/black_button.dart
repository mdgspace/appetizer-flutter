import 'package:flutter/material.dart';

class BlackButton extends StatelessWidget {
  const BlackButton({
    required this.title,
    required this.onTap,
    required this.width,
    Key? key,
  }) : super(key: key);

  final Function() onTap;
  final String title;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: width,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFF6F6F6),
            fontSize: 12,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w700,
            height: 1.50,
          ),
        ),
      ),
    );
  }
}

class BlackIconButton extends StatelessWidget {
  const BlackIconButton({
    required this.title,
    required this.onTap,
    required this.width,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final Function() onTap;
  final String title;
  final double width;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: width,
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Color(0xFFF6F6F6),
                fontSize: 12,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                height: 1.50,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 14,
              width: 14,
              alignment: Alignment.centerRight,
              child: Image.asset('assets/images/icons/submit_icon.png'),
            ),
          ],
        ),
      ),
    );
  }
}
