import 'package:flutter/material.dart';

import '/presentation/splash/splash_view/splash_widget/animation_widget.dart';

import '../../resources/app_constants.dart';
import 'splash_animation/splash_staggerd_animation.dart';
import 'splash_widget/splash_widget.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late SplashStaggerdAnimation animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppConstants.splashDuration),
    );
    animation = SplashStaggerdAnimation(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (controller.value > 0.69)
            SplashWidget(controller: controller, animation: animation)
          else
            AnimationWidget(
              color: Theme.of(context).colorScheme.primary,
              controller: controller,
              animation: animation,
            ),
        ],
      ),
    );
  }
}
