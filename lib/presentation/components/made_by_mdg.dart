import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MadeByMDG extends StatelessWidget {
  const MadeByMDG({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/images/made_by_mdg.svg");
  }
}
