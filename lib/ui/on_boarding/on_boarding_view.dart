import 'package:appetizer/app_theme.dart';
import 'package:appetizer/ui/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class OnBoardingView extends StatefulWidget {
  static const String id = 'on_boarding_view';

  @override
  _OnBoarding createState() => _OnBoarding();
}

class _OnBoarding extends State<OnBoardingView> {
  Widget _buildOnBoardingComponent(
      String title, String subtitle, String imagePath) {
    return Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(6.r),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTheme.headline3.copyWith(
                color: AppTheme.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(6.r),
            child: Image.asset(imagePath),
          ),
          Container(
            padding: EdgeInsets.all(6.r),
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppTheme.subtitle1.copyWith(
                  color: AppTheme.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondary,
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            onTap: () => Get.offAllNamed(LoginView.id),
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16),
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Swiper.children(
        autoplay: true,
        pagination: SwiperPagination(),
        children: <Widget>[
          _buildOnBoardingComponent(
            'Legible display of mess menu',
            'Switch between Day and Week view of mess menu',
            'assets/images/on_boarding_1.png',
          ),
          _buildOnBoardingComponent(
            'Check-in/Check-out whenever you want',
            'One-button check-Out feature to leave mess in sequence',
            'assets/images/on_boarding_2.png',
          ),
          _buildOnBoardingComponent(
            'Skip a Particular meal',
            'Not excited about the meal leave it and get rebate',
            'assets/images/on_boarding_3.png',
          ),
          _buildOnBoardingComponent(
            'A self-sustained system for feedback and suggestions',
            'One place to manage all your feedback',
            'assets/images/on_boarding_4.png',
          ),
        ],
      ),
    );
  }
}
