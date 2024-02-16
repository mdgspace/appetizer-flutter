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
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProfileBanner(),
          BlocBuilder<ProfilePageBloc, ProfilePageState>(
            builder: (context, state) {
              if (state is ProfilePageFetchedState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                            padding: EdgeInsets.symmetric(
                              vertical: 24.toAutoScaledHeight,
                              // horizontal: 43.toAutoScaledWidth,
                            ),
                            child: Column(
                              children: [
                                Row(
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
                                      horizontalPadding: 10,
                                      width: 115,
                                    ),
                                    // 5.toHorizontalSizedBox,
                                    ProfileTextButton(
                                      title: 'Reset Password',
                                      onPressed: () {
                                        context.router
                                            .push(ResetPasswordRoute());
                                      },
                                      horizontalPadding: 10,
                                      width: 115,
                                    ),
                                  ],
                                ),
                                10.toVerticalSizedBox,
                                if (state.hostelChangeStatus.isApproved == null)
                                  ProfileTextButton(
                                    title: 'Request for Hostel Change',
                                    onPressed: () {
                                      context.router.push(HostelChangeRoute());
                                    },
                                    horizontalPadding: 50,
                                    width: 248,
                                  ),
                                if (state.hostelChangeStatus.isApproved != null)
                                  TextButton(
                                    onPressed: () => {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                                title: const Text(
                                                    'Cancel Hostel Change Request'),
                                                content: const Text(
                                                  'You have already requested for a hostel change. Do you want to cancel it?',
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              ProfilePageBloc>()
                                                          .add(
                                                              const DeleteHostelChangeRequest());
                                                      ctx.router.pop();
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        ctx.router.pop(),
                                                    child: const Text('Cancel'),
                                                  )
                                                ],
                                              ))
                                    },
                                    child: Container(
                                      width: 248.toAutoScaledWidth,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 6.toAutoScaledHeight,
                                        horizontal: 22.toAutoScaledWidth,
                                      ),
                                      color: const Color(0xFFF6F6F6),
                                      child: Column(children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Requested for hostel change to ${state.hostelChangeStatus.hostelCode}",
                                            style: TextStyle(
                                              color: const Color(0xFF111111),
                                              fontSize: 13.toAutoScaledFont,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "New Room No: ${state.hostelChangeStatus.newRoomNo}",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: const Color(0xFF2F2F2F),
                                              fontSize: 12.toAutoScaledFont,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Status: Pending",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: const Color(0xFF2F2F2F),
                                              fontSize: 12.toAutoScaledFont,
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  )
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
                            padding:
                                EdgeInsets.only(top: 24.toAutoScaledHeight),
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
                            width: 101.toAutoScaledWidth,
                          ),
                          SizedBox(height: 18.toAutoScaledHeight),
                          const RaiseQueryButton(),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return SizedBox(
                height: 200.toAutoScaledHeight,
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: LoadingIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
