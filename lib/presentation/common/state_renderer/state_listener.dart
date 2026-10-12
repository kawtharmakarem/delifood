import 'dart:async';

import 'package:flutter/material.dart';
import '/app/di.dart';
import '/presentation/common/state_renderer/dialog_services.dart';
import '/presentation/common/state_renderer/presentation_style.dart';
import '/presentation/common/state_renderer/state_renderer.dart';
import '/presentation/resources/app_assets.dart';

import 'flow_state.dart';

class StateListener extends StatefulWidget {
  const StateListener({super.key, required this.child, required this.stream});
  final Widget child;
  final Stream<FlowState> stream;

  @override
  State<StateListener> createState() => _StateListenerState();
}

class _StateListenerState extends State<StateListener> {
  StreamSubscription<FlowState>? _subscription;
  final _dialogServices = instance<DialogServices>();
  FlowState _state = const InitialState();
  @override
  void initState() {
    super.initState();
    _subscription = widget.stream.listen(_handle);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant StateListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.stream != widget.stream) {
      _subscription?.cancel();
      _subscription = widget.stream.listen(_handle);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = _state;
    if (state is LoadingState && state.style == PresentationStyle.fullScreen) {
      return StateRenderer(
        animation: AnimatedAssets.loading,
        message: state.message,
        fullScreen: true,
      );
    }
    if (state is ErrorState && state.style == PresentationStyle.fullScreen) {
      return StateRenderer(
        animation: AnimatedAssets.error,
        message: state.failure.message,
        onRetry: state.onRetry,
        fullScreen: true,
      );
    }
    return widget.child;
  }

  void _handle(FlowState? state) {
    if (!mounted || state == null) return;
    switch (state) {
      case InitialState():
      case ContentState():
        _dialogServices.dismiss(context);
      case LoadingState(:final style, :final message):
        if (style == PresentationStyle.popup) {
          _dialogServices.showLoading(context, message: message);
        } else {
          _dialogServices.dismiss(context);
        }

      case ErrorState(:final style, :final failure, :final onRetry):
        if (style == PresentationStyle.popup) {
          _dialogServices.showError(
            context,
            message: failure.message,
            onRetry: onRetry,
          );
        } else {
          _dialogServices.dismiss(context);
        }
      case SuccessState(:final message):
        _dialogServices.showSuccess(context, message: message);
    }
    setState(() {
      _state = state;
    });
  }
}
