import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rui/storage/rui_storage_manager.dart';

class ThemeModel with ChangeNotifier {
  ThemeModel();

  void setThemeModel(ThemeModel tm) {
    _themeMode = tm.themeMode;
    _themeSeedColor = tm.themeSeedColor;
    notifyListeners();
  }

  String _themeSeedColor = 'blue';
  String get themeSeedColor => _themeSeedColor;
  void setThemeSeedColor(String color) async {
    _themeSeedColor = color;
    print("select $_themeSeedColor");
    await RuiStorageManager.setString('seedColor', color);
    notifyListeners(); //通知依赖的Widget更新
  }

  // Color _themeColorSeed = Colors.blue;
  // Color get themeColorSeed => _themeColorSeed;

  // setThemeColorSeed(String themeColorSeed) {
  //   themeColorSeed = themeColorSeed;
  //   notifyListeners();
  // }

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  setThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    print("select $_themeMode");
    await RuiStorageManager.setString('themeMode', themeMode.name);
    notifyListeners();
  }
}
