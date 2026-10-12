import '/core/resources/app_fonts.dart';
import 'package:flutter/material.dart';

class AppStyles {
  AppStyles._();
  static TextStyle _getTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    double letterSpacing = 1,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: AppFonts.oswald,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  static TextStyle regular(double fontSize) {
    return _getTextStyle(fontSize: fontSize, fontWeight: FontWeight.normal);
  }

  static TextStyle medium(double fontSize) {
    return _getTextStyle(fontSize: fontSize, fontWeight: FontWeight.w500);
  }

  static TextStyle semiBold(double fontSize) {
    return _getTextStyle(fontSize: fontSize, fontWeight: FontWeight.w600);
  }

  static TextStyle bold(double fontSize) {
    return _getTextStyle(fontSize: fontSize, fontWeight: FontWeight.w700);
  }
}
