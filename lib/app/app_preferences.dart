import '/presentation/resources/language_manager.dart';

import 'package:shared_preferences/shared_preferences.dart';

const String PREF_KEY_LANG = "PREF_KEY_LANG";
const String PREF_KEY_TOKEN = "PREF_KEY_TOKEN";
const String PREF_KEY_LOGIN = "PREF_KEY_LOGIn";

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);
  //language
  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREF_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    }
    return LanguageType.english.getValue();
  }

  Future<void> setAppLanguage(String language) async {
    await _sharedPreferences.setString(PREF_KEY_LANG, language);
  }

  Future<String?> getToken() async {
    return _sharedPreferences.getString(PREF_KEY_TOKEN);
  }

  Future<void> setToken(String token) async {
    await _sharedPreferences.setString(PREF_KEY_TOKEN, token);
  }

  //login
  Future<void> setUserLoggedIn() async {
    await _sharedPreferences.setBool(PREF_KEY_LOGIN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREF_KEY_LOGIN) ?? false;
  }

  //logout
  Future<void> logout() async {
    _sharedPreferences.remove(PREF_KEY_LOGIN);
  }
}
