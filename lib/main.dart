import 'package:appetizer/colors.dart';
import 'package:appetizer/globals.dart';
import 'package:appetizer/locator.dart';
import 'package:appetizer/managers/dialog_manager.dart';
import 'package:appetizer/services/analytics_service.dart';
import 'package:appetizer/services/navigation_service.dart';
import 'package:appetizer/styles.dart';
import 'package:appetizer/ui/router.dart';
import 'package:appetizer/ui/startup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
 *  Architectural Design GuideLines -
 *  1. Provider package for all the dynamic widgets and data.
 *  2. GetIt for dependency injection.
 *  3. Inherited Widget for the static data.
 *
 *  Rules of Thumb:
 *  a) Any class in the ui directory must not import from services in any case.
 *  b) Any Future must be called only once in the whole lifecycle of the app for static data, and on data changes for dynamic data.
 *
 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register all the models and services before the app starts
  await setupLocator();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MaterialApp(
        onGenerateRoute: Router.generateRoute,
        builder: (context, child) => Navigator(
          onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child),
          ),
        ),
        navigatorKey: locator<NavigationService>().navigatorKey,
        navigatorObservers: [
          locator<AnalyticsService>().getAnalyticsObserver(),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Appetizer',
        theme: ThemeData(
          primarySwatch: MaterialColor(
            appiYellow.value,
            primarySwatchColor,
          ),
          fontFamily: 'OpenSans',
          primaryColor: appiYellow,
          accentColor: appiGrey,
          cursorColor: appiYellow,
          accentTextTheme: accentTextTheme,
          primaryTextTheme: primaryTextTheme,
        ),
        home: StartupView(),
      ),
    );
  });
}
