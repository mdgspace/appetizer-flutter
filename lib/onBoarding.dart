import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'colors.dart';
import 'login.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoarding createState() => _OnBoarding();
}

class _OnBoarding extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: appiBrown,
      appBar: AppBar(
        actions: <Widget>[
          new GestureDetector(
            child: Container(
              child: Text("SKIP",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subhead
                      .copyWith(fontSize: 17, color: appiYellow)),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ],
        backgroundColor: appiBrown,
        elevation: 0.0,
      ),
      body: new Swiper.children(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 24, bottom: 48),
            alignment: Alignment.center,
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: new Text(
                    "Legible display of mess menu",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .display2
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Image(
                    image: AssetImage("assets/images/onBoarding1.png"),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: new Text(
                      "Switch between Day and Week view of mess menu",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .display2
                          .copyWith(
                              fontSize: 18,
                              fontFamily: "OpenSans-Light.ttf",
                              fontWeight: FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 24, bottom: 48),
            alignment: Alignment.center,
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: new Text(
                    "Check-in/Check-out whenever you want",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .display2
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Image(
                    image: AssetImage("assets/images/onBoarding2.png"),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: new Text(
                      "One-button check-Out feature to leave mess in sequence",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .display2
                          .copyWith(
                              fontSize: 18,
                              fontFamily: "OpenSans-Light.ttf",
                              fontWeight: FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 24, bottom: 48),
            alignment: Alignment.center,
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: new Text(
                    "Skip a Particular meal",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .display2
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Image(
                    image: AssetImage("assets/images/onBoarding3.png"),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: new Text(
                      "Not excited about the meal leave it and get rebate",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .display2
                          .copyWith(
                              fontSize: 18,
                              fontFamily: "OpenSans-Light.ttf",
                              fontWeight: FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
          ),
          new Container(
            margin: EdgeInsets.only(top: 24, bottom: 48),
            alignment: Alignment.center,
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: new Text(
                    "A self-sustained system for feedback and suggestions",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .display2
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Image(
                    image: AssetImage("assets/images/onBoarding4.png"),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: new Text(
                      "One place to manage all your feedback",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .display2
                          .copyWith(
                              fontSize: 18,
                              fontFamily: "OpenSans-Light.ttf",
                              fontWeight: FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
        viewportFraction: 0.9,
        scale: 0.7,
        loop: false,
        index: 0,
        autoplay: true,
        autoplayDisableOnInteraction: true,
        autoplayDelay: 4000,
        pagination: new SwiperPagination(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
