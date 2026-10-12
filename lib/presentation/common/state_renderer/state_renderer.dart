// import 'package:flutter/material.dart';
// import 'package:foodmvvm/presentation/resources/app_assets.dart';
// import 'package:foodmvvm/presentation/resources/app_values.dart';
// import 'package:lottie/lottie.dart';

// import '../../resources/app_strings.dart';

// class StateRenderer extends StatelessWidget {
//   const StateRenderer({super.key, required this.child});
//   final Widget child;
//   factory StateRenderer.loading() {
//     return StateRenderer(
//       child: PopupBody(animationImage: AnimatedAssets.loading),
//     );
//   }
//   factory StateRenderer.fullScreenLoading({
//     String message = AppStrings.loading,
//   }) {
//     return StateRenderer(
//       child: FullScreenBody(
//         animationImage: AnimatedAssets.loading,
//         message: message,
//       ),
//     );
//   }
//   factory StateRenderer.error(String message, VoidCallback onRetry) {
//     return StateRenderer(
//       child: PopupBody(
//         animationImage: AnimatedAssets.error,
//         message: message,
//         onRetry: onRetry,
//         buttonTitle: AppStrings.retry,
//       ),
//     );
//   }
//   factory StateRenderer.fullScreenError(String message, VoidCallback onRetry) {
//     return StateRenderer(
//       child: FullScreenBody(
//         animationImage: AnimatedAssets.error,
//         message: message,
//         onRetry: onRetry,
//         buttonTitle: AppStrings.retry,
//       ),
//     );
//   }
//   factory StateRenderer.success(
//     String message, {
//     String title = AppStrings.success,
//   }) {
//     return StateRenderer(
//       child: PopupBody(
//         animationImage: AnimatedAssets.success,
//         title: title,
//         message: message,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return child;
//   }
// }

// class FullScreenBody extends StatelessWidget {
//   const FullScreenBody({
//     super.key,
//     required this.animationImage,
//     this.title,
//     this.message,
//     this.onRetry,
//     this.buttonTitle,
//   });
//   final String animationImage;
//   final String? title;
//   final String? message;
//   final VoidCallback? onRetry;
//   final String? buttonTitle;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(AppPadding.p15),
//         child: Column(
//           children: [
//             SizedBox(
//               height: AppSize.s150,
//               width: AppSize.s150,
//               child: Lottie.asset(animationImage, fit: BoxFit.cover),
//             ),
//             if (title != null) ...[
//               Text(title!, style: Theme.of(context).textTheme.titleMedium),
//               SizedBox(height: AppSize.s10),
//             ],
//             if (message != null) ...[
//               Text(message!, style: Theme.of(context).textTheme.labelMedium),
//             ],
//             if (buttonTitle != null)
//               ElevatedButton(onPressed: onRetry, child: Text(buttonTitle!)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PopupBody extends StatelessWidget {
//   const PopupBody({
//     super.key,
//     required this.animationImage,
//     this.title,
//     this.message,
//     this.onRetry,
//     this.buttonTitle,
//   });
//   final String animationImage;
//   final String? title;
//   final String? message;
//   final VoidCallback? onRetry;
//   final String? buttonTitle;

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadiusGeometry.circular(AppRadius.r12),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(AppPadding.p15),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(
//               height: AppSize.s100,
//               width: AppSize.s100,
//               child: Lottie.asset(animationImage, fit: BoxFit.cover),
//             ),
//             if (title != null) ...[
//               Text(title!, style: Theme.of(context).textTheme.titleMedium),
//               SizedBox(height: AppSize.s10),
//             ],
//             if (message != null) ...[
//               Text(message!, style: Theme.of(context).textTheme.labelMedium),
//             ],
//             if (buttonTitle != null)
//               ElevatedButton(onPressed: onRetry, child: Text(buttonTitle!)),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '/presentation/resources/app_strings.dart';
import '/presentation/resources/app_values.dart';

import 'package:lottie/lottie.dart';

class StateRenderer extends StatelessWidget {
  const StateRenderer({
    super.key,
    required this.animation,
    this.title,
    this.message,
    this.onRetry,
    this.fullScreen = false,
  });
  final String animation;
  final String? title;
  final String? message;
  final VoidCallback? onRetry;
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: fullScreen ? 150 : 100,
          width: fullScreen ? 150 : 50,
          child: Lottie.asset(animation, fit: BoxFit.cover),
        ),
        if (title != null) ...[
          SizedBox(height: AppSize.s10),
          Text(title!, style: Theme.of(context).textTheme.titleMedium),
        ],
        if (message != null) ...[
          const SizedBox(height: AppSize.s10),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
        if (onRetry != null) ...[
          const SizedBox(height: AppSize.s15),
          ElevatedButton(onPressed: onRetry, child: Text(AppStrings.retry)),
        ],
      ],
    );
    if (fullScreen) {
      return Center(
        child: Padding(padding: EdgeInsets.all(AppPadding.p15), child: content),
      );
    }
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: Padding(padding: EdgeInsets.all(AppPadding.p15), child: content),
    );
  }
}
