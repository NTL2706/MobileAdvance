import 'package:final_project_advanced_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ThemeService {
  final _box = sharedPreferences;
  final _key = 'isDartTheme';
  _saveThemeToBox(bool isDartMode) => _box.setBool(_key, isDartMode);

  bool _loadThemeFromBox() => _box.getBool(_key) ?? false;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
