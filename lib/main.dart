import 'package:appetizer/app_theme.dart';
import 'package:appetizer/config/environment_config.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/services/analytics_service.dart';
import 'package:appetizer/ui/router.dart';
import 'package:appetizer/ui/startup_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as fs;
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/*
 *  Architectural Design GuideLines -
 *  1. Provider package for all the dynamic widgets and data.
 *  2. GetIt for dependency injection.
 *  3. Inherited Widget for the static data.
 *
 *  Rules of Thumb:
 *  a) Any class in the ui directory must not import from services in any case.
 *  b) Any Future must be called only once in the whole lifecycle of the app for static data, and on data changes for dynamic data.
 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize Firebase App
  await Firebase.initializeApp();

  // Register all the models and services before the app starts
  await setupLocator();

  await SentryFlutter.init(
    (options) {
      options.dsn = EnvironmentConfig.SENTRY_DSN;
    },
    // Init your App.
    appRunner: () => runApp(Appetizer()),
  );
}

class Appetizer extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    fs.SystemChrome.setPreferredOrientations(
      [
        fs.DeviceOrientation.portraitUp,
        fs.DeviceOrientation.portraitDown,
      ],
    );
    fs.SystemChrome.setSystemUIOverlayStyle(
      fs.SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: fs.Brightness.dark,
      ),
    );
    return GetMaterialApp(
      title: 'Appetizer',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppetizerRouter.generateRoute,
      navigatorObservers: [
        locator<AnalyticsService>().getAnalyticsObserver(),
      ],
      theme: ThemeData(
        fontFamily: 'Open Sans',
        primarySwatch: MaterialColor(
          0xFFFFC107,
          {
            50: Color(0xFFFFC107).withOpacity(0.1),
            100: Color(0xFFFFC107).withOpacity(0.2),
            200: Color(0xFFFFC107).withOpacity(0.3),
            300: Color(0xFFFFC107).withOpacity(0.4),
            400: Color(0xFFFFC107).withOpacity(0.5),
            500: Color(0xFFFFC107).withOpacity(0.6),
            600: Color(0xFFFFC107).withOpacity(0.7),
            700: Color(0xFFFFC107).withOpacity(0.8),
            800: Color(0xFFFFC107).withOpacity(0.9),
            900: Color(0xFFFFC107).withOpacity(1.0),
          },
        ),
        primaryColor: AppTheme.primary,
        hintColor: AppTheme.secondary,
        scaffoldBackgroundColor: AppTheme.white,
        dividerColor: AppTheme.grey,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: AppTheme.secondary,
          iconTheme: IconThemeData(color: AppTheme.primary),
          actionsIconTheme: IconThemeData(color: AppTheme.primary),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppTheme.primary,
        ),
        textTheme: TextTheme(
          headline1: AppTheme.headline1,
          headline2: AppTheme.headline2,
          headline3: AppTheme.headline3,
          headline4: AppTheme.headline4,
          headline5: AppTheme.headline5,
          headline6: AppTheme.headline6,
          subtitle1: AppTheme.subtitle1,
          subtitle2: AppTheme.subtitle2,
          bodyText1: AppTheme.bodyText1,
          bodyText2: AppTheme.bodyText2,
          button: AppTheme.button,
          overline: AppTheme.overline,
        ),
        primaryTextTheme: TextTheme(
          headline1: AppTheme.headline1.copyWith(color: AppTheme.white),
          headline2: AppTheme.headline2.copyWith(color: AppTheme.white),
          headline3: AppTheme.headline3.copyWith(color: AppTheme.white),
          headline4: AppTheme.headline4.copyWith(color: AppTheme.white),
          headline5: AppTheme.headline5.copyWith(color: AppTheme.white),
          headline6: AppTheme.headline6.copyWith(color: AppTheme.white),
          subtitle1: AppTheme.subtitle1.copyWith(color: AppTheme.white),
          subtitle2: AppTheme.subtitle2.copyWith(color: AppTheme.white),
          bodyText1: AppTheme.bodyText1.copyWith(color: AppTheme.white),
          bodyText2: AppTheme.bodyText2.copyWith(color: AppTheme.white),
          button: AppTheme.button.copyWith(color: AppTheme.white),
          overline: AppTheme.overline.copyWith(color: AppTheme.white),
        ),
      ),
      home: StartUpView(),
    );
  }
}
