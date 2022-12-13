import 'package:appetizer/app_theme.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/components/appetizer_error_widget.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/password/reset_password_view.dart';
import 'package:appetizer/ui/settings/edit_profile_view.dart';
import 'package:appetizer/ui/settings/components/user_details_card.dart';
import 'package:appetizer/utils/string_utils.dart';
import 'package:appetizer/viewmodels/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:appetizer/ui/help/help_view.dart';

class SettingsView extends StatelessWidget {
  static const String id = 'settings_view';

  Widget _buildListItem({
    required IconData iconData,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              iconData,
              color: AppTheme.primary,
              size: 20.r,
            ),
            SizedBox(width: 12.r),
            Text(
              '$title',
              style: AppTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMadeByMdgComponent() {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Made with ',
            style: AppTheme.subtitle2,
          ),
          Icon(
            Icons.favorite,
            color: AppTheme.red,
            size: 16.r,
          ),
          Text(
            ' by .mdg',
            style: AppTheme.subtitle2,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewModel>(
      onModelReady: (model) => model.getUserDetails(),
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'Settings'),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: AppTheme.secondary,
                height: 250.h,
                alignment: Alignment.center,
                child: () {
                  switch (model.state) {
                    case ViewState.Idle:
                      return UserDetailsCard(
                        name: model.userDetails.name,
                        enrollmentNo: model.userDetails.enrNo.toString(),
                        branch: model.userDetails.branch,
                        hostel: model.userDetails.hostelName,
                        roomNo: model.userDetails.roomNo,
                        email: model.userDetails.email,
                      );

                    case ViewState.Busy:
                      return AppetizerProgressWidget();

                    case ViewState.Error:
                      return AppetizerErrorWidget(
                        errorMessage: model.errorMessage,
                        onRetryPressed: model.getUserDetails,
                        textColor: AppTheme.white,
                      );

                    default:
                      return Container();
                  }
                }(),
              ),
              Container(
                color: AppTheme.white,
                child: Column(
                  children: <Widget>[
                    _buildListItem(
                      iconData: Icons.person,
                      title: 'Edit Profile',
                      onTap: () => Get.toNamed(EditProfileView.id),
                    ),
                    Divider(height: 0),
                    _buildListItem(
                      iconData: Icons.lock,
                      title: 'Reset Password',
                      onTap: () => Get.toNamed(ResetPasswordView.id),
                    ),
                    // Divider(height: 0),
                    // _buildListItem(
                    //   iconData: Icons.help,
                    //   title: 'FAQ',
                    //   onTap: () => Get.toNamed(FaqView.id),
                    // ),
                    Divider(height: 0),
                    _buildListItem(
                      iconData: Icons.info,
                      title: 'About',
                      onTap: () => Get.toNamed(HelpView.id),
                    ),
                    Divider(height: 0),
                    _buildListItem(
                      iconData: Icons.share,
                      title: 'Share/Tell a friend',
                      onTap: () => Share.share(
                        StringUtils.appLinkToShareText(model.appetizerLink),
                      ),
                    ),
                    Divider(height: 0),
                    _buildListItem(
                      iconData: Icons.exit_to_app,
                      title: 'Log Out',
                      onTap: model.onLogoutTap,
                    ),
                    Divider(height: 0),
                    _buildMadeByMdgComponent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
