import 'dart:math';

import 'package:flutter/material.dart';

class RipplePageRoute extends PageRoute<void> {
  final Widget page;
  final Offset tapPosition;
  final Color rippleColor;

  RipplePageRoute({
    required this.page,
    required this.tapPosition,
    this.rippleColor = Colors.white,
  }) : super(fullscreenDialog: false);

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;
  @override
  bool get opaque => true;
  @override
  Duration get transitionDuration => const Duration(milliseconds: 700);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return page;
  }

  @override
  bool get maintainState => true;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _RippleTransition(
      animation: animation,
      tapPosition: tapPosition,
      rippleColor: rippleColor,
      child: child,
    );
  }
}

class _RippleTransition extends StatelessWidget {
  final Animation<double> animation;
  final Offset tapPosition;
  final Color rippleColor;
  final Widget child;
  const _RippleTransition({
    required this.animation,
    required this.tapPosition,
    required this.rippleColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return CustomPaint(
          painter: _RipplePainter(
            tapPosition: tapPosition,
            progress: animation.value,
            color: rippleColor,
          ),
          child: animation.value > 0.99 ? child : SizedBox.expand(),
        );
      },
    );
  }
}

class _RipplePainter extends CustomPainter {
  final Offset tapPosition;
  final double progress;
  final Color color;
  _RipplePainter({
    required this.tapPosition,
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final maxRadius = [
      Offset(0, 0),
      Offset(size.width, 0),
      Offset(0, size.height),
      Offset(size.width, size.height),
    ].map((c) => (c - tapPosition).distance).reduce(max);

    double curvedProgress = Curves.easeInOut.transform(progress);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(tapPosition, maxRadius * curvedProgress, paint);
  }

  @override
  bool shouldRepaint(covariant _RipplePainter old) {
    return old.progress != progress;
  }
}
