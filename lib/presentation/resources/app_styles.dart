import 'package:flutter/material.dart';

import '/presentation/resources/app_fonts.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontFamily: FontFamily.nunito,
    fontWeight: fontWeight,
    fontSize: fontSize,
    color: color,
  );
}

//light
TextStyle getLightStyle({required double fontSize}) {
  return _getTextStyle(fontSize, FontWeight.w300, Colors.black);
}

//regular
TextStyle getRegularStyle({required double fontSize}) {
  return _getTextStyle(fontSize, FontWeight.w400, Colors.black);
}

//Medium
TextStyle getMediumStyle({required double fontSize}) {
  return _getTextStyle(fontSize, FontWeight.w500, Colors.black);
}

//Semibold
TextStyle getSemiBoldStyle({required double fontSize}) {
  return _getTextStyle(fontSize, FontWeight.w600, Colors.black);
}

//Black
TextStyle getBoldStyle({required double fontSize}) {
  return _getTextStyle(fontSize, FontWeight.w700, Colors.black);
}

//Custom styles
//logo style
