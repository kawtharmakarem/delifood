import 'package:flutter/material.dart';

import '/presentation/resources/app_colors.dart';
import '/presentation/resources/app_fonts.dart';
import '/presentation/resources/app_styles.dart';

import 'app_values.dart';

class AppTheme {
  AppTheme._();

  static final ColorScheme _lightColorScheme =
      ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ).copyWith(
        primary: AppColors.primary,
        onPrimary: AppColors.black,
        error: AppColors.error,
        surface: AppColors.white,
        onSecondary: AppColors.lightGrey,
        onSurface: AppColors.black,
        surfaceContainer: AppColors.smokeWhite,

        outline: AppColors.lightGrey,
      );
  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
  );
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: FontFamily.nunito,
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: _lightColorScheme.surface,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: _lightColorScheme.onSurface,
      ), //logo
      labelLarge: getMediumStyle(fontSize: FontSize.f16)
          .copyWith(color: _lightColorScheme.onSurface),
      titleLarge: getBoldStyle(fontSize: FontSize.f18),
      titleMedium: getBoldStyle(fontSize: FontSize.f16)
          .copyWith(color: _lightColorScheme.onSurface),
      labelMedium: getMediumStyle(fontSize: FontSize.f14)
          .copyWith(color: _lightColorScheme.onSurface),
      labelSmall: getRegularStyle(fontSize: FontSize.f14)
          .copyWith(color: _lightColorScheme.onSecondary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        foregroundColor: _lightColorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.r12),
        ),
        backgroundColor: _lightColorScheme.primary,

        textStyle: getBoldStyle(fontSize: FontSize.f16),
      ),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      labelStyle: getRegularStyle(fontSize: FontSize.f14)
          .copyWith(color: _lightColorScheme.outline),
      hintStyle: getRegularStyle(fontSize: FontSize.f14)
          .copyWith(color: _lightColorScheme.outline),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: _lightColorScheme.outline),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _lightColorScheme.outline),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _lightColorScheme.error),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _lightColorScheme.primary, width: 1.2),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _lightColorScheme.error, width: 1.2),
      ),
      errorStyle: getRegularStyle(fontSize: 14)
          .copyWith(color: _lightColorScheme.error),
      suffixIconColor: _lightColorScheme.outline,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _lightColorScheme.primary,
        textStyle: getBoldStyle(fontSize: FontSize.f14),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        iconSize: 28,
        foregroundColor: _lightColorScheme.onPrimary,
      ),
    ),
    searchBarTheme: SearchBarThemeData(
      padding: WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: AppPadding.p10),
      ),
      backgroundColor: WidgetStatePropertyAll(_lightColorScheme.surface),
      hintStyle: WidgetStatePropertyAll(
        getRegularStyle(fontSize: FontSize.f14),
      ),
      elevation: WidgetStatePropertyAll(0.0),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(AppRadius.r8),
        ),
      ),
    ),
  );
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: FontFamily.nunito,
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: _darkColorScheme.surface,
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: _darkColorScheme.onSurface,
      ),
    ),
  );
}
