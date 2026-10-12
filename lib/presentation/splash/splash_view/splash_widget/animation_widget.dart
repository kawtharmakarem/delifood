import 'package:flutter/material.dart';

import '/presentation/resources/app_colors.dart';
import '/presentation/splash/splash_view/splash_animation/splash_staggerd_animation.dart';

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({
    super.key,
    required this.color,
    required this.controller,
    required this.animation,
  });
  final Color color;
  final AnimationController controller;
  final SplashStaggerdAnimation animation;

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  Size size = Size.zero;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: HolePainter(
              widget.color,
              widget.animation.holeSize.value * size.width,
            ),
          ),
        ),
        Positioned(
          top: widget.animation.dropPosition.value * size.height,
          left: size.width / 2 - widget.animation.dropSize.value / 2,
          child: SizedBox(
            height: widget.animation.dropSize.value,
            width: widget.animation.dropSize.value,
            child: CustomPaint(
              painter: DropPainter(
                visible: widget.animation.dropVisible.value,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DropPainter extends CustomPainter {
  bool visible;
  Color color;
  DropPainter({this.visible = true, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    if (!visible) return;
    final capPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final stemPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final stem = Path();
    stem.moveTo(size.width * 0.4, size.height * 0.52);
    stem.quadraticBezierTo(
      size.width * 0.33,
      size.height * 0.8,
      size.width * 0.45,
      size.height * 0.95,
    );
    stem.lineTo(size.width * 0.55, size.height * 0.95);
    stem.quadraticBezierTo(
      size.width * 0.67,
      size.height * 0.8,
      size.width * 0.6,
      size.height * 0.52,
    );
    stem.close();
    canvas.drawPath(stem, stemPaint);
    final cap = Path();
    cap.moveTo(size.width * 0.15, size.height * 0.55);
    cap.quadraticBezierTo(
      size.width * 0.2,
      size.height * 0.05,
      size.width * 0.5,
      size.height * 0.08,
    );
    cap.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.05,
      size.width * 0.85,
      size.height * 0.55,
    );
    cap.quadraticBezierTo(
      size.width * 0.5,
      size.height * 0.45,
      size.width * 0.15,
      size.height * 0.55,
    );
    canvas.drawPath(cap, capPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HolePainter extends CustomPainter {
  Color color;
  double holeSize;
  HolePainter(this.color, this.holeSize);
  @override
  void paint(Canvas canvas, Size size) {
    double radius = holeSize / 2;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect outerCircleRect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );
    Rect innerCircleRect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius / 2,
    );
    Path transparentHole = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()
        ..addOval(outerCircleRect)
        ..close(),
    );
    Path innerHole = Path.combine(
      PathOperation.difference,
      Path()
        ..addOval(outerCircleRect)
        ..close(),
      Path()
        ..addOval(innerCircleRect)
        ..close(),
    );
    canvas.drawPath(transparentHole, Paint()..color = color);
    canvas.drawPath(innerHole, Paint()..color = color.withValues(alpha: 0.5));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
