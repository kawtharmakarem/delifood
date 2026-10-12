import '/features/splash/presentation/screens/splash_screen.dart';

import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();
  static const String splashRoute = "/splashRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold());
    }
  }
}
