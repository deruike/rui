import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeModel with ChangeNotifier {
  String _seedColor = 'blue';
  String get seedColor => _seedColor;
  void setTheme(color) async {
    _seedColor = color;
    print(_seedColor);
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
  setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    print(_themeMode);
    notifyListeners();
  }
}
