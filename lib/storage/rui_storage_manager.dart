import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rui/provider/theme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RuiStorageManager {
  static SharedPreferences? _sp;

  RuiStorageManager();

  static Future<SharedPreferences> getSharedPreferences() async {
    _sp ??= await SharedPreferences.getInstance();

    return _sp!;
  }

  static Future<bool> load() async {
    var sp = await getSharedPreferences();

    // ThemeModel.setThemeMode(  sp.getString("themeMode") ?? "system") ;

    return true;
  }

  static Future<bool> save() async {
    var sp = await getSharedPreferences();
    return true;
  }

  static Future<void> setString(String key, String value) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();

      sp.setString(key, value);
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> getString(String key) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();

      return sp.getString(key);
    } catch (e) {
      print(e);
    }
  }
}
