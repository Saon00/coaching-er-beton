import 'package:coachingerbeton/views/components/colors.dart';
import 'package:coachingerbeton/views/components/fonts.dart';
import 'package:flutter/material.dart';

class ThemeContoller with ChangeNotifier {
  ThemeData _themeData = ThemeData(
      appBarTheme: AppBarTheme(
          color: primaryColor,
          centerTitle: true,
          titleTextStyle: titlePopins.copyWith(
              fontSize: 20, color: blackColor, fontWeight: FontWeight.bold)));

  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == ThemeData.light()) {
      themeData = ThemeData.dark();
    } else {
      themeData = ThemeData.light();
    }
  }

  bool _isDark = false;
  bool get isDark => _isDark;
  set isDark(bool value) {
    _isDark = value;
    notifyListeners();
  }

  changeTheme() {
    isDark = !_isDark;
  }
}
