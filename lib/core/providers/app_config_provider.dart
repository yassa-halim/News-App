import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  void changeTheme(ThemeMode newTheme) async {
    if (themeMode == newTheme) return;
    themeMode = newTheme;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    pref.setBool("isDark", isDark);
  }

  void toggleTheme() {
    changeTheme(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  bool get isDark => themeMode == ThemeMode.dark;

  String local = "en";

  void changeLocal(String newLocal) async {
    if (local == newLocal) return;
    local = newLocal;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    pref.setString("locale", local);
  }

  void toggleLocale() {
    changeLocal(isEn ? "ar" : "en");
  }

  bool get isEn => local == "en";
}
