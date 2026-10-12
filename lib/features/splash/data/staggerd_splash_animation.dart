import 'package:flutter/material.dart';

class StaggerdSplashAnimation {
  final AnimationController controller;
  final Animation<double> dropPosition;
  final Animation<double> ballSize;
  final Animation<bool> visible;
  final Animation<double> rippleSize;
  //start screen animations
  final Animation<double> logoScale;
  final Animation<double> logoFade;
  //getstartedButton
  final Animation<double> buttonFade;
  final Animation<double> buttonSlide;
  //white Screen

  StaggerdSplashAnimation(this.controller)
    : ballSize = Tween<double>(begin: 50, end: 70).animate(controller),
      dropPosition = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 0,
            //end: 0.55,
            end: 0.8,
          ).chain(CurveTween(curve: Curves.easeIn)),
          weight: 55,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 0.8,
            end: 0.55,
          ).chain(CurveTween(curve: Curves.easeOut)),
          weight: 25,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 0.55,
            end: 0.65,
          ).chain(CurveTween(curve: Curves.easeIn)),
          weight: 20,
        ),
      ]).animate(controller),
      visible = Tween<bool>(begin: true, end: false).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.75, 0.75, curve: Curves.easeOut),
        ),
      ),
      rippleSize = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.75, 1, curve: Curves.easeOut),
        ),
      ),
      logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.35, curve: Curves.easeIn),
        ),
      ),
      logoScale = Tween<double>(begin: 0.7, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.35, curve: Curves.easeOutBack),
        ),
      ),
      buttonFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.3, 0.5, curve: Curves.easeIn),
        ),
      ),
      buttonSlide = Tween<double>(begin: 0, end: 40).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.3, 0.5, curve: Curves.easeOut),
        ),
      );
}
