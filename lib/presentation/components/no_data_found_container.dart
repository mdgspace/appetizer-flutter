import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

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
      padding: EdgeInsets.only(top: 150.toAutoScaledHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TODO: check why svg doesnt work
          // SvgPicture.asset(
          //   'assets/images/no_data_image.svg',
          //   // 'assets/images/no_data_image.svg',
          //   height: 178.toAutoScaledHeight,
          //   width: 186.toAutoScaledWidth,
          // ),
          Image.asset(
            'assets/images/no_data_image.png',
            height: 178.toAutoScaledHeight,
            width: 186.toAutoScaledWidth,
          ),
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFF111111),
              fontSize: 18.toAutoScaledFont,
              fontFamily: 'Noto Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
