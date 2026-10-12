import 'package:flutter/material.dart';

class StaggerdAuthAnimation {
  final AnimationController controller;
  final Animation<double> logoScale;
  final Animation<double> logoFade;
  final Animation<double> tabsFade;
  final Animation<double> tabsSlide;
  final Animation<double> forgotFade;
  final Animation<double> forgotSlide;
  // final Animation<double> logoShrink;
  // final Animation<double> logoMoveUp;
  final Animation<double> emailFade;
  final Animation<double> emailSlide;
  final Animation<double> passwordFade;
  final Animation<double> passwordSlide;

  final Animation<bool> visibleAnim;
  final Animation<double> floatAnim;
  final Animation<double> scaleAnim;
  final Animation<double> buttonSlide;
  final Animation<double> buttonFade;
  //for register tab
  final Animation<double> regUserNameFade;
  final Animation<double> regUserNameSlide;
  final Animation<double> regEmailFade;
  final Animation<double> regEmailSlide;
  final Animation<double> regPasswordFade;
  final Animation<double> regPasswordSlide;
  final Animation<double> regConfirmFade;
  final Animation<double> regConfirmSlide;
  final Animation<double> regButtonFade;
  final Animation<double> regButtonSlide;
  StaggerdAuthAnimation(this.controller)
    : logoFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0, 0.18, curve: Curves.easeOut),
        ),
      ),
      logoScale = Tween<double>(begin: 0.5, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.0, 0.22, curve: Curves.easeOutBack),
        ),
      ),
      tabsFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.20, 0.32, curve: Curves.easeOut),
        ),
      ),
      tabsSlide = Tween<double>(begin: -20, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.20, 0.32, curve: Curves.easeOut),
        ),
      ),

      forgotFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.70, 0.78, curve: Curves.easeOut),
        ),
      ),
      forgotSlide = Tween<double>(begin: -15, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.70, 0.78, curve: Curves.easeOut),
        ),
      ),

      // logoShrink = Tween<double>(begin: 1.0, end: 0.88).animate(
      //   CurvedAnimation(
      //     parent: controller,
      //     curve: const Interval(0.34, 0.44, curve: Curves.fastOutSlowIn),
      //   ),
      // ),
      // logoMoveUp = Tween<double>(begin: 0.0, end: -16).animate(
      //   CurvedAnimation(
      //     parent: controller,
      //     curve: const Interval(0.40, 0.55, curve: Curves.fastOutSlowIn),
      //   ),
      // ),
      emailFade = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.52, 0.64, curve: Curves.easeOut),
        ),
      ),
      emailSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.52, 0.64, curve: Curves.easeOut),
        ),
      ),
      passwordFade = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.60, 0.72, curve: Curves.easeOut),
        ),
      ),
      passwordSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.60, 0.72, curve: Curves.easeOut),
        ),
      ),

      visibleAnim = Tween<bool>(begin: false, end: true).animate(
        CurvedAnimation(parent: controller, curve: const Interval(0.92, 0.92)),
      ),
      floatAnim = Tween<double>(begin: 0, end: -3).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.92, 1, curve: Curves.easeOut),
        ),
      ),
      scaleAnim = Tween<double>(begin: 0.7, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.92, 1, curve: Curves.easeOut),
        ),
      ),
      buttonFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.80, 0.95, curve: Curves.easeOut),
        ),
      ),
      buttonSlide = Tween<double>(begin: -40, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.80, 0.95, curve: Curves.easeOut),
        ),
      ),
      regUserNameFade = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.52, 0.64, curve: Curves.easeOut),
        ),
      ),
      regUserNameSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.52, 0.64, curve: Curves.easeOut),
        ),
      ),
      regEmailFade = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.58, 0.70, curve: Curves.easeOut),
        ),
      ),
      regEmailSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.58, 0.70, curve: Curves.easeOut),
        ),
      ),
      regPasswordFade = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.64, 0.76, curve: Curves.easeOut),
        ),
      ),
      regPasswordSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.64, 0.76, curve: Curves.easeOut),
        ),
      ),
      regConfirmFade = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.70, 0.82, curve: Curves.easeOut),
        ),
      ),
      regConfirmSlide = Tween<double>(begin: -25, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.70, 0.82, curve: Curves.easeOut),
        ),
      ),
      regButtonFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.82, 0.96, curve: Curves.easeOut),
        ),
      ),
      regButtonSlide = Tween<double>(begin: -40, end: 0).animate(
        CurvedAnimation(
          parent: controller,
          curve: const Interval(0.82, 0.96, curve: Curves.easeOut),
        ),
      );
}
