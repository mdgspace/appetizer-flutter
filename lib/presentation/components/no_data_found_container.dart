import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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
          Container(
            padding: EdgeInsets.only(top: 150.toAutoScaledHeight),
            height: 178.toAutoScaledHeight,
            width: 186.toAutoScaledWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: Svg('assets/images/no_data_image.svg'),
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF111111),
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
