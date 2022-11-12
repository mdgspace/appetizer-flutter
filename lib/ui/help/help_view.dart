import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/viewmodels/help/help_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpView extends StatelessWidget {
  static const String id = 'help_view';

  @override
  Widget build(BuildContext context) {
    return BaseView<HelpViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppetizerAppBar(title: 'About Us'),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: AppTheme.secondary,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image(
                        image: AssetImage('assets/images/about_pattern.png'),
                        width: 170.r,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 12.r),
                            child: Material(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image(
                                image: AssetImage(
                                  'assets/icons/logo_rounded.png',
                                ),
                                width: 70.r,
                              ),
                            ),
                          ),
                          Image(
                            image: AssetImage(
                              'assets/images/appetizer_text.png',
                            ),
                            width: 60.r,
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.r),
                            child: Text(
                              'Version ${model.appetizerVersion}',
                              style: AppTheme.bodyText2.copyWith(
                                color: AppTheme.lightGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.r),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Developed by',
                      style: AppTheme.bodyText2.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(6.r),
                      child: Image(
                        image: AssetImage('assets/images/mdg.png'),
                        height: 30.r,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(6.r),
                      child: Text(
                        'MDG Space, IIT Roorkee',
                        style: AppTheme.bodyText1,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: launchGithubUrl,
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: Image(
                                  image: AssetImage('assets/images/github.png'),
                                  width: 32.r,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: launchFbUrl,
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: Image(
                                  image: AssetImage('assets/images/fb.png'),
                                  width: 32.r,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: launchWebUrl,
                              child: Padding(
                                padding: EdgeInsets.all(12.r),
                                child: Image(
                                  image: AssetImage('assets/images/web.png'),
                                  width: 32.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void launchFbUrl() {
  launchUrlString('https://m.facebook.com/mdgspace/');
}

void launchGithubUrl() {
  launchUrlString('https://github.com/mdgspace/');
}

void launchWebUrl() {
  launchUrlString('https://mdg.iitr.ac.in/');
}
