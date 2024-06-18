import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rui/storage/rui_storage_manager.dart';

class ThemeModel with ChangeNotifier {
  Future<void> load() async {
    _seedColor =
        await RuiStorageManager.getString('theme_seed_color') ?? 'blue';
    notifyListeners();
  }

  Future<void> save() async {
    await RuiStorageManager.setString('theme_seed_color', _seedColor);
  }

  String _seedColor = 'blue';
  String get seedColor => _seedColor;
  void setTheme(color) async {
    _seedColor = color;
    print("select $_seedColor");
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
