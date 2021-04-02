import 'package:appetizer/app_theme.dart';
import 'package:appetizer/enums/view_state.dart';
import 'package:appetizer/ui/FAQ/faq_view.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/ui/components/appetizer_progress_widget.dart';
import 'package:appetizer/ui/password/reset_password_view.dart';
import 'package:appetizer/ui/settings/edit_profile_view.dart';
import 'package:appetizer/ui/settings/components/user_details_card.dart';
import 'package:appetizer/utils/string_utils.dart';
import 'package:appetizer/viewmodels/settings/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:appetizer/ui/help/help_view.dart';

class Settings extends StatelessWidget {
  static const String id = 'settings_view';

  Widget _buildListItem({IconData iconData, String title, VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              iconData,
              color: AppTheme.primary,
              size: 30.0,
            ),
            SizedBox(width: 16),
            Text(
              '$title',
              style: AppTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMadeByMdgComponent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Made with ',
            style: AppTheme.subtitle1,
          ),
          Icon(
            Icons.favorite,
            color: AppTheme.red,
          ),
          Text(
            ' by MDG',
            style: AppTheme.subtitle1,
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
                height: MediaQuery.of(context).size.height / 2 -
                    AppBar().preferredSize.height,
                alignment: Alignment.center,
                child: (model.state == ViewState.Busy)
                    ? AppetizerProgressWidget()
                    : UserDetailsCard(
                        name: model.userDetails.name,
                        enrollmentNo: model.userDetails.enrNo.toString(),
                        branch: model.userDetails.branch,
                        hostel: model.userDetails.hostelName,
                        roomNo: model.userDetails.roomNo,
                        email: model.userDetails.email,
                      ),
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
                    Divider(height: 0),
                    _buildListItem(
                      iconData: Icons.help,
                      title: 'FAQ',
                      onTap: () => Get.toNamed(FaqView.id),
                    ),
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
