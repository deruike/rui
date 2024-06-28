import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rui/provider/session_model.dart';
import 'package:rui/provider/theme_model.dart';
import 'package:rui/theme/rui_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RuiStorageManager {
  static SharedPreferences? _sp;

  RuiStorageManager();

  static Future<SharedPreferences> getSharedPreferences() async {
    _sp ??= await SharedPreferences.getInstance();

    return _sp!;
  }

  static Future<ThemeModel> load() async {
    var sp = await getSharedPreferences();

    ThemeModel themeModel = ThemeModel();

    themeModel.setThemeMode((sp.getString("themeMode") ?? "system") == "system"
        ? ThemeMode.system
        : ThemeMode.light);

    String cl = sp.getString("seedColor") ?? "blueGrey";
    themeModel.setThemeSeedColor(cl);

    return themeModel;
  }

  static Future<SessionModel> loadSession() async {
    var sp = await getSharedPreferences();

    SessionModel sessionModel = SessionModel();

    sessionModel.setToken(sp.getString("token") ?? "");
    sessionModel.setUserId(sp.getString("userId") ?? "");

    return sessionModel;
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
