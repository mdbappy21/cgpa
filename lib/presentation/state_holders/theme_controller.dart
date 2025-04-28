import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  RxBool isDarkMode = false.obs;

  static const String themeKey = 'theme_mode';

  @override
  void onInit() {
    super.onInit();
    loadThemeFromCache();
  }

  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }
    isDarkMode.value = themeMode.value == ThemeMode.dark; // update boolean
    saveThemeToCache();
  }

  void setTheme(ThemeMode mode) {
    themeMode.value = mode;
    isDarkMode.value = mode == ThemeMode.dark; // update boolean
    saveThemeToCache();
  }

  Future<void> loadThemeFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString(themeKey);

    if (savedTheme == 'dark') {
      themeMode.value = ThemeMode.dark;
      isDarkMode.value = true;
    } else {
      themeMode.value = ThemeMode.light;
      isDarkMode.value = false;
    }
  }

  Future<void> saveThemeToCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        themeKey, themeMode.value == ThemeMode.dark ? 'dark' : 'light');
  }
}
