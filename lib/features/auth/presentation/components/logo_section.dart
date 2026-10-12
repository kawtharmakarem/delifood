import '/features/auth/data/staggerd_auth_animation.dart';
import '/core/resources/app_assets.dart';
import '/core/resources/app_colors.dart';
import '/core/resources/app_strings.dart';
import '/core/resources/app_styles.dart';

import 'package:flutter/material.dart';

class LogoSection extends StatefulWidget {
  const LogoSection({
    super.key,
    required this.controller,
    required this.animation,
  });
  final AnimationController controller;
  final StaggerdAuthAnimation animation;

  @override
  State<LogoSection> createState() => _LogoSectionState();
}

class _LogoSectionState extends State<LogoSection> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (_, child) {
        return Transform.scale(
          scale: widget.animation.logoScale.value,
          child: Opacity(
            opacity: widget.animation.logoFade.value,
            child: child!,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppAssets.logo, width: size.width * 0.38),
          SizedBox(height: size.height * 0.01),
          Text(AppStrings.logoText, style: AppStyles.bold(32)),
          SizedBox(height: size.height * 0.01),
          Text(
            AppStrings.delivery,
            style: AppStyles.regular(20).copyWith(color: AppColors.lightBlack),
          ),
        ],
      ),
    );
  }
}
