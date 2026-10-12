import 'dart:math';
import 'dart:ui';

import '/features/auth/cubit/auth_cubit.dart';
import '/features/auth/data/staggerd_auth_animation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_state.dart';

class StickersSection extends StatefulWidget {
  const StickersSection({
    super.key,
    required this.controller,
    required this.animation,
  });
  final AnimationController controller;
  final StaggerdAuthAnimation animation;

  @override
  State<StickersSection> createState() => _StickersSectionState();
}

class _StickersSectionState extends State<StickersSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            return AnimatedBuilder(
              animation: widget.controller,
              builder: (_, _) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: cubit.items.map((item) {
                    final start = item.delay;
                    final end = start + 0.25;
                    final t = Curves.easeOutCubic.transform(
                      Interval(
                        start,
                        end.clamp(0.0, 1.0),
                      ).transform(widget.controller.value),
                    );
                    final x = lerpDouble(item.startX, item.endX, t)!;
                    final curve = sin(t * pi) * item.arcHeight;
                    final y = lerpDouble(item.startY, item.endy, t)! + curve;
                    return Positioned(
                      left: x * width - item.size / 2,
                      top: y * height - item.size / 2,
                      child: Visibility(
                        visible: widget.animation.visibleAnim.value,
                        child: Transform.translate(
                          offset: Offset(0, widget.animation.floatAnim.value),
                          child: Transform.scale(
                            scale: widget.animation.scaleAnim.value,
                            child: Transform.rotate(
                              angle: item.rotation + item.rotationSpeed * t,
                              child: Image.asset(
                                item.image,
                                width: item.size,
                                height: item.size,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        );
      },
    );
  }
}
