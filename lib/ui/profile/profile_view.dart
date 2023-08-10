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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: const Color(0xFFFFCB74),
        toolbarHeight: 120,
      ),
      // TODO: implement Old/New notification bars and logic
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  width: 18,
                ),
                ProfileTextButton(
                  title: 'Reset Password',
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 35, right: 35, top: 24),
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
          // TODO: Logout Button
          // TODO: Raise a Query Button
        ],
      ),
    );
  }
}
