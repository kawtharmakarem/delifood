import 'package:flutter/material.dart';

import '/app/app_preferences.dart';
import '/app/di.dart';
import '/presentation/resources/app_assets.dart';
import '/presentation/resources/app_routes.dart';
import '/presentation/resources/app_strings.dart';
import '/presentation/resources/app_values.dart';
import '/presentation/splash/splash_view/splash_animation/splash_staggerd_animation.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({
    super.key,
    required this.controller,
    required this.animation,
  });
  final AnimationController controller;
  final SplashStaggerdAnimation animation;

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  Size size = Size.zero;
  AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          Spacer(),
          ScaleTransition(
            scale: widget.animation.logoScale,
            child: FadeTransition(
              opacity: widget.animation.logoFade,
              child: _logo(),
            ),
          ),
          Spacer(),
          SlideTransition(
            position: widget.animation.buttonSlide,
            child: FadeTransition(
              opacity: widget.animation.buttonFade,
              child: _getStarted(),
            ),
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }

  Widget _logo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppAssets.logo,
          height: size.height * 0.15,
          width: size.width * 0.35,
          fit: BoxFit.fill,
        ),
        SizedBox(height: AppSize.s5),
        Text(
          AppStrings.logoText,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }

  Widget _getStarted() {
    return SizedBox(
      height: AppSize.s50,
      width: size.width * 0.7,
      child: ElevatedButton(
        onPressed: () async {
          _appPreferences.isUserLoggedIn().then((isLoggedIn) {
            if (!mounted) return;
            if (isLoggedIn) {
              Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
            } else {
              Navigator.of(context).pushReplacementNamed(Routes.authRoute);
            }
          });
        },

        child: Text(AppStrings.getStarted),
      ),
    );
  }
}
