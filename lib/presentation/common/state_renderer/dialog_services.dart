import 'package:flutter/material.dart';
import '/presentation/common/state_renderer/state_renderer.dart';
import '/presentation/resources/app_assets.dart';
import '/presentation/resources/app_strings.dart';

class DialogServices {
  bool _isDialogRouteOpen = false;
  final ValueNotifier<Widget?> _content = ValueNotifier(null);

  void _ensureOpen(BuildContext context) {
    if (_isDialogRouteOpen) return;
    _isDialogRouteOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return ValueListenableBuilder<Widget?>(
          valueListenable: _content,
          builder: (context, content, _) => content ?? const SizedBox.shrink(),
        );
      },
    ).whenComplete(() {
      _isDialogRouteOpen = false;
    });
  }

  void _update(BuildContext context, Widget content) {
    _ensureOpen(context);
    _content.value = content; // ← فقط تحديث المحتوى، من غير أي pop/push
  }

  void showLoading(
    BuildContext context, {
    String message = AppStrings.loading,
  }) {
    _update(
      context,
      StateRenderer(animation: AnimatedAssets.loading, message: message),
    );
  }

  void showError(
    BuildContext context, {
    required String message,
    required VoidCallback onRetry,
  }) {
    _update(
      context,
      StateRenderer(
        animation: AnimatedAssets.error,
        message: message,
        onRetry: () {
          dismiss(context);
          onRetry();
        },
      ),
    );
  }

  void showSuccess(
    BuildContext context, {
    String title = AppStrings.success,
    required String message,
  }) {
    _update(
      context,
      StateRenderer(
        animation: AnimatedAssets.success,
        title: title,
        message: message,
      ),
    );
  }

  void dismiss(BuildContext context) {
    if (!_isDialogRouteOpen) return;
    final nav = Navigator.of(context, rootNavigator: true);
    if (nav.canPop()) {
      nav.pop();
    }
  }
}
