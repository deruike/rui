import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rui/storage/rui_storage_manager.dart';

class SessionModel with ChangeNotifier {
  SessionModel();

  void setSessionModel(SessionModel tm) {
    _token = tm.token;
    notifyListeners();
  }

  String _token = '';
  String get token => _token;
  void setToken(String token) async {
    _token = token;
    await RuiStorageManager.setString('token', _token);
    notifyListeners();
  }

  String _userId = '';
  String get userId => _userId;
  void setUserId(String userId) async {
    _userId = userId;
    await RuiStorageManager.setString('userId', _userId);
    notifyListeners();
  }
}
