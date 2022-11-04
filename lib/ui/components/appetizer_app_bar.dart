import 'package:appetizer/app_theme.dart';
import 'package:flutter/material.dart';

class AppetizerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double elevation;
  final Color? backgroundColor;
  final bool? centerTile;
  final List<Widget>? actions;

  const AppetizerAppBar({
    Key? key,
    required this.title,
    this.elevation = 0,
    this.backgroundColor,
    this.centerTile,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: AppTheme.headline3.copyWith(
          color: AppTheme.white,
        ),
      ),
      centerTitle: centerTile,
      elevation: elevation,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
