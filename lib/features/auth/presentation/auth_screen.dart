import '/features/auth/data/staggerd_auth_animation.dart';
import '/features/auth/presentation/components/logo_section.dart';
import '/features/auth/presentation/components/sign_section.dart';
import '/core/resources/app_colors.dart';
import '/core/resources/app_constants.dart';
import '/features/auth/presentation/components/stickers_section.dart';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late StaggerdAuthAnimation _animation;
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
      duration: const Duration(milliseconds: AppConstants.getStartedDuration),
    );
    _animation = StaggerdAuthAnimation(_controller);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              //stickerSection
              //if (_animation.visibleAnim.value)
              SizedBox(
                height: size.height * 0.2,
                child: StickersSection(
                  controller: _controller,
                  animation: _animation,
                ),
              ),
              //logoSection
              LogoSection(controller: _controller, animation: _animation),
              //SignSection
              SizedBox(height: size.height * 0.03),

              SignSection(controller: _controller, animation: _animation),
            ],
          ),
        ),
      ),
    );
  }
}
