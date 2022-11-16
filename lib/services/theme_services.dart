import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  _savethemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() {
    if (_box.read(_key) == true) {
      return true;
    }
    return false;
  }

  ThemeMode get theme {
    if (_loadThemeFromBox()) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _savethemeToBox(!_loadThemeFromBox());
  }
}
