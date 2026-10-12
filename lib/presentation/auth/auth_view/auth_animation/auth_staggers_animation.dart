import 'package:flutter/material.dart';

class AuthStaggersAnimation {
  final AnimationController controller;
  final Animation<double> logoFade;
  final Animation<double> logoScale;
  final Animation<double> tabsFade;
  final Animation<double> tabsSlide;
  final Animation<double> forgotFade;
  final Animation<double> forgotSlide;
  final Animation<double> logEmailFade;
  final Animation<double> logEmailSlide;
  final Animation<double> logPasswordFade;
  final Animation<double> logPasswordSlide;
  final Animation<double> logButtonFade;
  final Animation<double> logButtonSlide;
  //sticker todo
  final Animation<double> stickerFade;
  final Animation<double> stickerSlide;
  final Animation<double> regUserNameFade;
  final Animation<double> regUserNameSlide;
  final Animation<double> regEmailFade;
  final Animation<double> regEmailSlide;
  final Animation<double> regPasswordFade;
  final Animation<double> regPasswordSlide;
  final Animation<double> regProfileFade;
  final Animation<double> regProfileSlide;
  final Animation<double> regButtonFade;
  final Animation<double> regButtonSlide;

  AuthStaggersAnimation(this.controller)
    : logoFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.18, curve: Curves.easeOut),
        ),
      ),
      logoScale = Tween<double>(begin: 0.5, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.0, 0.22, curve: Curves.easeOutBack),
        ),
      ),
      tabsFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.2, 0.32, curve: Curves.easeOut),
        ),
      ),
      tabsSlide = Tween<double>(begin: -40, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.2, 0.32, curve: Curves.easeOut),
        ),
      ),
      forgotFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.32, 0.40, curve: Curves.easeOut),
        ),
      ),
      forgotSlide = Tween<double>(begin: -40, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.32, 0.4, curve: Curves.easeOut),
        ),
      ),
      logEmailFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.4, 0.5, curve: Curves.easeOut),
        ),
      ),
      logEmailSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.4, 0.5, curve: Curves.easeOut),
        ),
      ),
      logPasswordFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 0.6, curve: Curves.easeOut),
        ),
      ),
      logPasswordSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 0.6, curve: Curves.easeOut),
        ),
      ),
      logButtonFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.6, 0.7, curve: Curves.easeOut),
        ),
      ),
      logButtonSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.6, 0.7, curve: Curves.easeOut),
        ),
      ),
      regUserNameFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.4, 0.45, curve: Curves.easeOut),
        ),
      ),
      regUserNameSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.4, 0.45, curve: Curves.easeOut),
        ),
      ),
      regEmailFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.45, 0.5, curve: Curves.easeOut),
        ),
      ),
      regEmailSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.45, 0.5, curve: Curves.easeOut),
        ),
      ),
      regPasswordFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 0.55, curve: Curves.easeOut),
        ),
      ),
      regPasswordSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.5, 0.55, curve: Curves.easeOut),
        ),
      ),
      regProfileFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.55, 0.6, curve: Curves.easeOut),
        ),
      ),
      regProfileSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.55, 0.6, curve: Curves.easeOut),
        ),
      ),
      regButtonFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.6, 0.7, curve: Curves.easeOut),
        ),
      ),
      regButtonSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.6, 0.7, curve: Curves.easeOut),
        ),
      ),
      stickerFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.7, 1, curve: Curves.easeOut),
        ),
      ),
      stickerSlide = Tween<double>(begin: 40, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(0.7, 1, curve: Curves.easeOut),
        ),
      );
}
