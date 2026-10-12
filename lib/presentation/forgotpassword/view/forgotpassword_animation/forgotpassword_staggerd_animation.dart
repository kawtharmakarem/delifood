import 'package:flutter/cupertino.dart';

class ForgotpasswordStaggerdAnimation {
  final AnimationController controller;
  final Animation<double> emailFade;
  final Animation<double> emailSlide;
  final Animation<double> stickersFade;
  final Animation<double> stickersSlide;
  final Animation<double> logoFade;
  final Animation<double> logoScale;
  final Animation<double> buttonFade;
  final Animation<double> buttonSlide;

  ForgotpasswordStaggerdAnimation(this.controller)
    : logoFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.25, curve: Curves.easeOut),
        ),
      ),
      logoScale = Tween<double>(begin: 0.5, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.25, curve: Curves.easeOutBack),
        ),
      ),
      emailFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.25, 0.45, curve: Curves.easeOut),
        ),
      ),
      emailSlide = Tween<double>(begin: 40, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.25, 0.50, curve: Curves.easeOut),
        ),
      ),
      stickersFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.7, 1, curve: Curves.easeOut),
        ),
      ),
      stickersSlide = Tween<double>(begin: 40, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.7, 1, curve: Curves.easeOut),
        ),
      ),
      buttonSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 0.7, curve: Curves.easeOut),
        ),
      ),
      buttonFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 0.7, curve: Curves.easeOut),
        ),
      );
}
