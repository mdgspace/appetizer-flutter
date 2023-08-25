import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/user/user.dart';
import 'package:appetizer/presentation/components/black_button.dart';
import 'package:appetizer/presentation/profile/components/profile_button.dart';
import 'package:appetizer/presentation/profile/components/profile_card.dart';
import 'package:appetizer/presentation/profile/components/profile_photo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.data, Key? key}) : super(key: key);

  final User data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200.toAutoScaledHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFFFCB74),
            ),
            padding: EdgeInsets.only(left: 24.toAutoScaledWidth),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.toAutoScaledWidth,
                  fontFamily: 'Noto Sans',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -60),
            child: Column(
              children: [
                ProfilePhoto(
                  imageUri: data.imageUrl,
                ),
                Text(
                  data.name,
                  style: TextStyle(
                    color: const Color(0xFF111111),
                    fontSize: 25.toAutoScaledFont,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 33.toAutoScaledWidth,
                      right: 34.toAutoScaledWidth,
                      top: 22.toAutoScaledHeight),
                  child: ProfileCard(data: data),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 55.toAutoScaledWidth,
                      right: 57.toAutoScaledWidth,
                      top: 24.toAutoScaledHeight,
                      bottom: 24.toAutoScaledHeight),
                  child: Row(
                    children: [
                      ProfileTextButton(
                        title: 'Edit Profile',
                        onPressed: () {},
                      ),
                      SizedBox(
                        width: 10.toAutoScaledWidth,
                      ),
                      ProfileTextButton(
                        title: 'Reset Password',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 2,
                  thickness: 2,
                  color: Color.fromARGB(255, 189, 189, 189),
                  indent: 30,
                  endIndent: 30,
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 46.toAutoScaledWidth,
                      right: 48.toAutoScaledWidth,
                      top: 24.toAutoScaledHeight),
                  child: Row(
                    children: [
                      ProfileIconButton(
                        title: 'Bookmark',
                        onPressed: () {},
                        icon: Icons.bookmark_border_outlined,
                      ),
                      SizedBox(
                        width: 48.toAutoScaledWidth,
                      ),
                      ProfileIconButton(
                        title: 'Coupons',
                        onPressed: () {},
                        icon: Icons.bookmark_border_outlined,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.toAutoScaledHeight),
                BlackButton(
                  title: 'LOGOUT',
                  onTap: () {},
                  width: 101,
                ),
                SizedBox(height: 18.toAutoScaledHeight),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Raise a Query',
                    style: TextStyle(
                      color: const Color(0xFF008BFF),
                      fontSize: 12.toAutoScaledFont,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
