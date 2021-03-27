import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class AppetizerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double elevation;
  final bool centerTile;

  const AppetizerAppBar({
    Key key,
    @required this.title,
    this.elevation = 0,
    this.centerTile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTheme.headline5.copyWith(color: AppTheme.primary),
      ),
      centerTitle: centerTile,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
