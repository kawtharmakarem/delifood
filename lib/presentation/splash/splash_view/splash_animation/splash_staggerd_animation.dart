import 'package:flutter/material.dart';

class SplashStaggerdAnimation {
  final AnimationController controller;
  final Animation<double> dropSize;
  final Animation<double> dropPosition;
  final Animation<bool> dropVisible;
  final Animation<double> holeSize;
  //start
  final Animation<double> logoScale;
  final Animation<double> logoFade;
  final Animation<Offset> buttonSlide;
  final Animation<double> buttonFade;

  static final double maximumDropSize = 20;
  static final double maximumRelativeDropY = 0.5;
  static final double maximumHoleSize = 10;

  SplashStaggerdAnimation(this.controller)
    : dropSize = Tween<double>(begin: 0, end: maximumDropSize).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.2, curve: Curves.easeIn),
        ),
      ),
      dropPosition = Tween<double>(begin: 0, end: maximumRelativeDropY).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.2, 0.5, curve: Curves.easeIn),
        ),
      ),
      dropVisible = Tween<bool>(
        begin: true,
        end: false,
      ).animate(CurvedAnimation(parent: controller, curve: Interval(0.5, 0.5))),
      holeSize = Tween<double>(begin: 0, end: maximumHoleSize).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 0.7, curve: Curves.easeIn),
        ),
      ),
      logoFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.7, 0.85, curve: Curves.easeOut),
        ),
      ),
      logoScale = Tween<double>(begin: 0.7, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.7, 0.9, curve: Curves.easeOutBack),
        ),
      ),
      buttonFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.75, 1, curve: Curves.easeIn),
        ),
      ),
      buttonSlide = Tween<Offset>(begin: Offset(0, 40), end: Offset(0, 0))
          .animate(
            CurvedAnimation(
              parent: controller,
              curve: Interval(0.75, 1, curve: Curves.easeOut),
            ),
          );
}
