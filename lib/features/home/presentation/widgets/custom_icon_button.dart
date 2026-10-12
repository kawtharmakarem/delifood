import '/core/resources/app_colors.dart';

import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.iconData,
    required this.buttonIndex,
    required this.onPressed,
    required this.selectedIndex,
  });
  final IconData iconData;
  final int buttonIndex;
  final VoidCallback onPressed;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: buttonIndex == selectedIndex
            ? AppColors.primaryColor
            : AppColors.grey,
        size: 28,
      ),
    );
  }
}
