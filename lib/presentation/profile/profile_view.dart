import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/domain/models/user/user.dart';
import 'package:appetizer/domain/repositories/user_repository.dart';
import 'package:appetizer/presentation/components/app_banner.dart';
import 'package:appetizer/presentation/components/black_button.dart';
import 'package:appetizer/presentation/profile/bloc/profile_page_bloc.dart';
import 'package:appetizer/presentation/profile/components/profile_button.dart';
import 'package:appetizer/presentation/profile/components/profile_card.dart';
import 'package:appetizer/presentation/profile/components/profile_photo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.data, Key? key}) : super(key: key);

  final User data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            ProfilePageBloc(repo: context.read<UserRepository>()),
        child: BlocBuilder<ProfilePageBloc, ProfilePageState>(
          builder: (context, state) {
            if (state is ProfilePageInitialState) {
              context
                  .read<ProfilePageBloc>()
                  .add(const ProfilePageFetchEvent());
              return const Placeholder();
            }
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
                          imageUri: data.imageUrl,
                        ),
                        10.toVerticalSizedBox,
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
                              top: 24.toAutoScaledHeight,
                              bottom: 24.toAutoScaledHeight),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProfileTextButton(
                                title: 'Edit Profile',
                                onPressed: () {},
                              ),
                              10.toHorizontalSizedBox,
                              ProfileTextButton(
                                title: 'Reset Password',
                                onPressed: () {},
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
                              color: Color(0xFF008BFF),
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
          },
        ),
      ),
    );
  }
}
