import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({
    super.key,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
    required this.hint,
    required this.label,
    this.errorText,
    this.readOnly,
    this.onTap,
    required this.animationController,
    required this.animationValue,
    required this.animationOpacity,
  });
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String hint;
  final String label;
  final String? errorText;
  final bool? readOnly;
  final VoidCallback? onTap;
  final AnimationController animationController;
  final double animationValue;
  final Animation<double> animationOpacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animationValue),
          child: FadeTransition(
            opacity: animationOpacity,
            child: TextFormField(
              controller: controller,
              onTap: onTap,
              readOnly: readOnly ?? false,
              obscureText: obscureText,
              validator: validator,

              decoration: InputDecoration(
                hintText: hint,
                labelText: label,
                errorText: errorText,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
              ),
            ),
          ),
        );
      },
    );
  }
}
