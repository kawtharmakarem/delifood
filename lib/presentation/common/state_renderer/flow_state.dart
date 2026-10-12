// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

// import 'package:flutter/material.dart';
// import 'package:foodmvvm/presentation/common/state_renderer/presentation_style.dart';
// import 'package:foodmvvm/presentation/common/state_renderer/state_renderer.dart';

// import '../../../app/failure.dart';

// sealed class FlowState {
//   const FlowState();
//   Widget getScreenWidget({
//     required Widget contentScreenWidget,
//     VoidCallback? retryActionFunction,
//   });
// }

// //initstate
// final class InitialState extends FlowState {
//   const InitialState();

//   @override
//   Widget getScreenWidget({
//     required Widget contentScreenWidget,
//     VoidCallback? retryActionFunction,
//   }) {
//     return contentScreenWidget;
//   }
// }

// //content
// final class ContentState extends FlowState {
//   const ContentState();

//   @override
//   Widget getScreenWidget({
//     required Widget contentScreenWidget,
//     VoidCallback? retryActionFunction,
//   }) {
//     return contentScreenWidget;
//   }
// }

// //loading
// final class LoadingState extends FlowState {
//   final PresentationStyle presentationStyle;
//   final String message;
//   const LoadingState({required this.presentationStyle, required this.message});

//   @override
//   Widget getScreenWidget({
//     required Widget contentScreenWidget,
//     VoidCallback? retryActionFunction,
//   }) {
//     if (presentationStyle == PresentationStyle.fullScreen) {
//       return StateRenderer.fullScreenLoading(message: message);
//     }
//     return contentScreenWidget;
//   }
// }

// //error
// final class ErrorState extends FlowState {
//   final PresentationStyle presentationStyle;
//   final VoidCallback retryActionFunction;
//   final Failure failure;

//   ErrorState({
//     required this.presentationStyle,
//     required this.retryActionFunction, required this.failure,
//   });

//   @override
//   Widget getScreenWidget({
//     required Widget contentScreenWidget,
//     VoidCallback? retryActionFunction,
//   }) {
//     if (presentationStyle == PresentationStyle.fullScreen) {
//       return StateRenderer.fullScreenError(failure.message, retryActionFunction.call());
//     }
//     return contentScreenWidget;
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/app/failure.dart';
import '/presentation/common/state_renderer/presentation_style.dart';
import '/presentation/resources/app_strings.dart';

sealed class FlowState {
  const FlowState();
}

class InitialState extends FlowState {
  const InitialState();
}

class ContentState extends FlowState {
  const ContentState();
}

class LoadingState extends FlowState {
  final PresentationStyle style;
  final String message;
  const LoadingState({
    this.style = PresentationStyle.popup,
    this.message = AppStrings.loading,
  });
}

class ErrorState extends FlowState {
  final PresentationStyle style;
  final Failure failure;
  final VoidCallback onRetry;
  ErrorState({
    this.style = PresentationStyle.popup,
    required this.failure,
    required this.onRetry,
  });
}

class SuccessState extends FlowState {
  final String message;
  const SuccessState({required this.message});
}
