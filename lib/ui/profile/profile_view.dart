import 'package:appetizer_revamp_parts/models/user/user.dart';
import 'package:appetizer_revamp_parts/ui/profile/components/profile_button.dart';
import 'package:appetizer_revamp_parts/ui/profile/components/profile_card.dart';
import 'package:appetizer_revamp_parts/ui/profile/components/profile_photo.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    required this.data,
    Key? key,
  }) : super(key: key);

  final User data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: implement Old/New notification bars and logic
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFFFCB74),
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
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
                  style: const TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 25,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 33, right: 34, top: 22),
                  child: ProfileCard(data: data),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 55, right: 57, top: 24),
                  child: Row(
                    children: [
                      ProfileTextButton(
                        title: 'Edit Profile',
                        onPressed: () {},
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ProfileTextButton(
                        title: 'Reset Password',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 48,
                  thickness: 2,
                  color: Color.fromARGB(255, 189, 189, 189),
                  indent: 30,
                  endIndent: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 46, right: 48, top: 24),
                  child: Row(
                    children: [
                      ProfileIconButton(
                        title: 'Bookmark',
                        onPressed: () {},
                        icon: Icons.bookmark_border_outlined,
                      ),
                      const SizedBox(
                        width: 48,
                      ),
                      ProfileIconButton(
                        title: 'Coupons',
                        onPressed: () {},
                        icon: Icons.bookmark_border_outlined,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // TODO: Logout Button
          // TODO: Raise a Query Button
        ],
      ),
    );
  }
}
