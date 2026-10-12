import '/features/splash/presentation/widgets/get_started_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/app_assets.dart';
import '../../../../core/resources/app_colors.dart';
import '../../../../core/resources/app_strings.dart';
import '../../../../core/resources/app_styles.dart';
import '../../data/staggerd_splash_animation.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late StaggerdSplashAnimation _animation;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _animation = StaggerdSplashAnimation(_controller);
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: FadeTransition(
            opacity: _animation.logoFade,
            child: ScaleTransition(
              scale: _animation.logoScale,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(AppAssets.logo, width: 100, height: 100),
                  const SizedBox(height: 12),
                  Text(
                    AppStrings.logoText,
                    style: AppStyles.bold(
                      32,
                    ).copyWith(color: AppColors.white, letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 40 + _animation.buttonSlide.value,
          left: 75,
          right: 75,
          child: FadeTransition(
            opacity: _animation.buttonFade,
            child: GetStartedButton(),
          ),
        ),
      ],
    );
  }
}
