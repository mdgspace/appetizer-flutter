import 'package:flutter/material.dart';

class NoDataFoundContainer extends StatelessWidget {
  const NoDataFoundContainer({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 150),
            height: 178,
            width: 186,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/no_data_image.png'),
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF111111),
              fontSize: 18,
              fontFamily: 'Noto Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
