import 'package:appetizer/data/core/router/intrinsic_router/intrinsic_router.gr.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/presentation/components/app_banner.dart';
import 'package:appetizer/presentation/components/black_button.dart';
import 'package:appetizer/presentation/components/loading_indicator.dart';
import 'package:appetizer/presentation/profile/bloc/profile_page_bloc.dart';
import 'package:appetizer/presentation/profile/components/profile_button.dart';
import 'package:appetizer/presentation/profile/components/profile_card.dart';
import 'package:appetizer/presentation/profile/components/profile_photo.dart';
import 'package:appetizer/utils/app_extensions/app_extensions.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePageBloc, ProfilePageState>(
      builder: (context, state) {
        if (state is ProfilePageFetchedState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBanner(
                  height: 120.toAutoScaledHeight,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12.toAutoScaledWidth,
                      ),
                      Text(
                        'My Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.toAutoScaledWidth,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -60),
                  child: Column(
                    children: [
                      ProfilePhoto(
                        imageUri: state.user.imageUrl,
                      ),
                      10.toVerticalSizedBox,
                      Text(
                        state.user.name,
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
                          top: 22.toAutoScaledHeight,
                        ),
                        child: ProfileCard(data: state.user),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 24.toAutoScaledHeight,
                            bottom: 24.toAutoScaledHeight),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProfileTextButton(
                              title: 'Edit Profile',
                              onPressed: () {
                                const snackBar =
                                    SnackBar(content: Text('Coming soon!'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                            ),
                            10.toHorizontalSizedBox,
                            ProfileTextButton(
                              title: 'Reset Password',
                              onPressed: () {
                                const snackBar =
                                    SnackBar(content: Text('Coming soon!'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 2.toAutoScaledHeight,
                        thickness: 2,
                        color: const Color.fromARGB(255, 189, 189, 189),
                        indent: 30.toAutoScaledWidth,
                        endIndent: 30.toAutoScaledWidth,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 24.toAutoScaledHeight),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // TODO: add bookamark button
                            // ProfileIconButton(
                            //   title: 'Bookmark',
                            //   onPressed: () {},
                            //   icon: Icons.bookmark_border_outlined,
                            // ),
                            // 48.toHorizontalSizedBox,
                            ProfileIconButton(
                              title: 'Coupons',
                              onPressed: () => BaseApp.router.navigateToPage(
                                const CouponsRoute(),
                              ),
                              icon: Icons.bookmark_border_outlined,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.toAutoScaledHeight),
                      BlackButton(
                        title: 'LOGOUT',
                        onTap: () {
                          const snackBar =
                              SnackBar(content: Text('Coming soon!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        width: 101,
                      ),
                      SizedBox(height: 18.toAutoScaledHeight),
                      TextButton(
                        onPressed: () {
                          const snackBar = SnackBar(
                              content: Text('Contact us at mdg@iitr.ac.in'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
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

        return const Center(
          child: LoadingIndicator(),
        );
      },
    );
  }
}
