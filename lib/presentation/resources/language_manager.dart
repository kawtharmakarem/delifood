import 'package:flutter/material.dart';

import '/presentation/resources/app_strings.dart';

enum LanguageType { english, arabic }

const Locale arabicLocale = Locale("ar", "SA");
const Locale englishLocale = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return AppStrings.english;
      case LanguageType.arabic:
        return AppStrings.arabic;
    }
  }
}
