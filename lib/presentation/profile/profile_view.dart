import 'package:appetizer/data/constants/constants.dart';
import 'package:appetizer/data/core/router/intrinsic_router/intrinsic_router.gr.dart';
import 'package:appetizer/data/core/theme/dimensional/dimensional.dart';
import 'package:appetizer/data/services/local/local_storage_service.dart';
import 'package:appetizer/presentation/app/bloc/app_bloc.dart';
import 'package:appetizer/presentation/components/black_button.dart';
import 'package:appetizer/presentation/components/loading_indicator.dart';
import 'package:appetizer/presentation/components/raise_query_button.dart';
import 'package:appetizer/presentation/profile/bloc/profile_page_bloc.dart';
import 'package:appetizer/presentation/profile/components/profile_banner.dart';
import 'package:appetizer/presentation/profile/components/profile_button.dart';
import 'package:appetizer/presentation/profile/components/profile_card.dart';
import 'package:appetizer/presentation/profile/components/profile_photo.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
                const ProfileBanner(),
                Transform.translate(
                  offset: const Offset(0, -60),
                  child: Column(
                    children: [
                      ProfilePhoto(
                        imageUri: state.user.imageUrl ?? '',
                      ),
                      10.toVerticalSizedBox,
                      Text(
                        state.user.name,
                        style: GoogleFonts.notoSans(
                          color: const Color(0xFF111111),
                          fontSize: 25.toAutoScaledFont,
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
                                const snackBar = SnackBar(
                                  content: Text('Coming soon!'),
                                  duration: Duration(milliseconds: 500),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                            ),
                            10.toHorizontalSizedBox,
                            ProfileTextButton(
                              title: 'Reset Password',
                              onPressed: () {
                                const snackBar = SnackBar(
                                  content: Text('Coming soon!'),
                                  duration: Duration(milliseconds: 500),
                                );
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
                            // TODO: add bookmark button
                            // ProfileIconButton(
                            //   title: 'Bookmark',
                            //   onPressed: () {},
                            //   icon: Icons.bookmark_border_outlined,
                            // ),
                            // 48.toHorizontalSizedBox,
                            ProfileIconButton(
                              title: 'Coupons',
                              onPressed: () =>
                                  context.router.push(const CouponsRoute()),
                              icon: Icons.bookmark_border_outlined,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.toAutoScaledHeight),
                      BlackButton(
                        title: 'LOGOUT',
                        onTap: () {
                          LocalStorageService.setValue(
                              key: AppConstants.LOGGED_IN, value: false);
                          LocalStorageService.setValue(
                              key: AppConstants.AUTH_TOKEN, value: null);
                          context
                              .read<AppBloc>()
                              .add(const NavigateToLoginScreen());
                        },
                        width: 101,
                      ),
                      SizedBox(height: 18.toAutoScaledHeight),
                      const RaiseQueryButton(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const Scaffold(
          body: Column(
            children: [
              ProfileBanner(),
              Center(
                child: LoadingIndicator(),
              ),
            ],
          ),
        );
      },
    );
  }
}
