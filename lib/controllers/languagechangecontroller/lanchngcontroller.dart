import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController extends ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;

  void changeLanguage(Locale locale) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _locale = locale;
    if (locale == const Locale('en')) {
      await sharedPreferences.setString('lang_code', 'en');
    } else {
      await sharedPreferences.setString('lang_code', 'bn');
    }

    notifyListeners();
  }
}
