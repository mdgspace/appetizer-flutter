import 'package:appetizer/colors.dart';
import 'package:appetizer/ui/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class OnBoarding extends StatefulWidget {
  static const String id = 'on_boarding_view';

  @override
  _OnBoarding createState() => _OnBoarding();
}

class _OnBoarding extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appiBrown,
      appBar: AppBar(
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16),
              child: Text('SKIP',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subtitle1
                      .copyWith(fontSize: 17, color: appiYellow)),
            ),
          ),
        ],
      ),
      body: Swiper.children(
        viewportFraction: 0.9,
        scale: 0.7,
        loop: false,
        index: 0,
        autoplay: true,
        autoplayDisableOnInteraction: true,
        autoplayDelay: 4000,
        pagination: SwiperPagination(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: Text(
                    'Legible display of mess menu',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline3
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: Image(
                    image: AssetImage('assets/images/on_boarding_1.png'),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text(
                      'Switch between Day and Week view of mess menu',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline3
                          .copyWith(
                              fontSize: 18,
                              fontFamily: 'OpenSans-Light.ttf',
                              fontWeight: FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: Text(
                    'Check-in/Check-out whenever you want',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline3
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: Image(
                    image: AssetImage('assets/images/on_boarding_2.png'),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text(
                      'One-button check-Out feature to leave mess in sequence',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline3
                          .copyWith(
                              fontSize: 18,
                              fontFamily: 'OpenSans-Light.ttf',
                              fontWeight: FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: Text(
                    'Skip a Particular meal',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline3
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: Image(
                    image: AssetImage('assets/images/on_boarding_3.png'),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text(
                      'Not excited about the meal leave it and get rebate',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline3
                          .copyWith(
                              fontSize: 18,
                              fontFamily: 'OpenSans-Light.ttf',
                              fontWeight: FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                  child: Text(
                    'A self-sustained system for feedback and suggestions',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline3
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Image(
                    image: AssetImage('assets/images/on_boarding_4.png'),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text(
                      'One place to manage all your feedback',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline3
                          .copyWith(
                              fontSize: 18,
                              fontFamily: 'OpenSans-Light.ttf',
                              fontWeight: FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
