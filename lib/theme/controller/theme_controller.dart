import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController{
  static String pkgName = "o_level_quiz_";
  static String IS_DARK_MODE = "${pkgName}themeMode";

  ThemeMode themeMode = ThemeMode.dark;
  bool isDarkTheme = false;

  SharedPreferences? prefs;


  @override
  void onInit() {
    setTheme();
    super.onInit();
  }


  Future<void> setTheme() async {
    prefs = await SharedPreferences.getInstance();
    themeMode = ThemeMode.values[prefs!.getInt(IS_DARK_MODE) ?? 1];
    // themeMode = ThemeMode.dark;
    isDarkTheme = themeMode == ThemeMode.dark;

    print("isDaark===$isDarkTheme");
    update();
  }

  void changeTheme(ThemeMode mode) async {
    // if (themeMode == ThemeMode.light)
    //   themeMode = ThemeMode.dark;
    // else
      themeMode = mode;
      // themeMode = ThemeMode.light;

    isDarkTheme = themeMode == ThemeMode.dark;

    print("theme===${themeMode.index}");

    if (prefs != null) {
      await prefs!.setInt(IS_DARK_MODE, themeMode.index);
    } else {
      prefs = await SharedPreferences.getInstance();
      await prefs!.setInt(IS_DARK_MODE, themeMode.index);
    }

    update();
  }

}