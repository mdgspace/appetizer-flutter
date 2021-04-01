import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/base_view.dart';
import 'package:appetizer/ui/components/appetizer_app_bar.dart';
import 'package:appetizer/viewmodels/help/help_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                        width: 280,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Material(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image(
                                image: AssetImage(
                                  'assets/icons/appetizer_logo.png',
                                ),
                                width: 100,
                              ),
                            ),
                          ),
                          Image(
                            image: AssetImage(
                              'assets/images/appetizer_text.png',
                            ),
                            width: 100,
                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
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
                padding: EdgeInsets.all(16),
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
                      padding: const EdgeInsets.all(8),
                      child: Image(
                        image: AssetImage('assets/images/mdg.png'),
                        height: 40,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Mobile Development Group, IIT Roorkee',
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
                                padding: EdgeInsets.all(16),
                                child: Image(
                                  image: AssetImage('assets/images/github.png'),
                                  width: 48,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: launchFbUrl,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Image(
                                  image: AssetImage('assets/images/fb.png'),
                                  width: 48,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: launchWebUrl,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Image(
                                  image: AssetImage('assets/images/web.png'),
                                  width: 48,
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
  launch('https://m.facebook.com/mdgiitr/');
}

void launchGithubUrl() {
  launch('https://github.com/mdg-iitr/');
}

void launchWebUrl() {
  launch('http://mdg.iitr.ac.in');
}
