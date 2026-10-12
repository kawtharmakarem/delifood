import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/resources/app_assets.dart';
import '../../../../core/resources/app_colors.dart';
import '../../data/staggerd_splash_animation.dart';
import 'get_started_screen.dart';

class AnimatedSplashPart extends StatefulWidget {
  const AnimatedSplashPart({super.key});

  @override
  State<AnimatedSplashPart> createState() => _AnimatedSplashPartState();
}

class _AnimatedSplashPartState extends State<AnimatedSplashPart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late StaggerdSplashAnimation _animation;
  Size screenSize = Size.zero;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _animation = StaggerdSplashAnimation(_controller);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      screenSize = MediaQuery.of(context).size;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: CustomPaint(
            painter: RipplePainter(
              progress: _animation.rippleSize.value,
              color: AppColors.primaryColor,
            ),
          ), //holePainter
        ),
        if (_animation.visible.value) _logoBall(),
        if (_controller.value >= 0.9) GetStartedScreen(),
      ],
    );
  }

  Positioned _logoBall() {
    return Positioned(
      left: (screenSize.width / 2) - (_animation.ballSize.value / 2),
      top:
          _animation.dropPosition.value *
          screenSize.height, //position 0 to 0.5 from height
      //center of the screen
      child: SizedBox(
        height: _animation.ballSize.value,
        width: _animation.ballSize.value,
        child: CustomPaint(
          painter: DropPainter(
            //visible: _animation.visible.value,
            radius: _animation.ballSize.value / 2,
            progress: _controller.value,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipOval(
              child: Image.asset(AppAssets.logo, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}

class DropPainter extends CustomPainter {
  //bool visible;
  double radius;
  double progress;
  DropPainter({
    //this.visible = true,
    required this.radius,
    required this.progress,
  });
  @override
  void paint(Canvas canvas, Size size) {
    //if (!visible) return;
    final paint = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.fill;
    double width = radius * 2;
    double height = radius * 2;
    if (progress < 0.55) {
      final fallProgress = progress / 0.55;
      final stretch = sin(fallProgress * pi * 0.5);
      height += stretch * 10;
      width -= stretch * 5;
    }
    if (progress >= 0.55 && progress <= 0.7) {
      final impact = ((progress - 0.55) / 0.15).clamp(0.0, 1);
      final squash = sin(impact * pi);
      width += squash * 20;
      height -= squash * 12;
    }
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: width,
      height: height,
    );
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RipplePainter extends CustomPainter {
  final double progress;
  final Color color;
  RipplePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final maxRadius = sqrt(pow(size.width, 2) + pow(size.height, 2));
    final radius = maxRadius * progress;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
