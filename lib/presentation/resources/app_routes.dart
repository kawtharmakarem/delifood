import 'package:flutter/material.dart';

import '/app/di.dart';
import '/presentation/auth/auth_view/auth_view.dart';
import '/presentation/forgotpassword/view/forgotpassword_view.dart';
import '/presentation/main/details/details_page.dart';
import '/presentation/main/main_view.dart';
import '/presentation/resources/app_strings.dart';
import '/presentation/resources/app_styles.dart';
import '/presentation/splash/splash_view/splash_view.dart';

class Routes {
  Routes._();
  static const String splashRoute = "/";
  static const String authRoute = "/auth";
  static const String mainRoute = "/main";
  static const String forgotpassword = "/forgotpassword";
  static const String detailsRoute = "/details";
}

class RouteGenerator {
  RouteGenerator._();
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.authRoute:
        initAuthmodule();
        return MaterialPageRoute(builder: (_) => AuthView());
      case Routes.mainRoute:
        initMain();
        return MaterialPageRoute(builder: (_) => MainView());

      case Routes.forgotpassword:
        initForgotpassword();
        return MaterialPageRoute(builder: (_) => ForgotpasswordView());

      case Routes.detailsRoute:
        initDetails();
        return MaterialPageRoute(
          builder: (_) => DetailsPage(),
          settings: settings,
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(AppStrings.noRoute)),
        body: Center(
          child: Text(AppStrings.noRoute, style: getBoldStyle(fontSize: 25)),
        ),
      ),
    );
  }
}
