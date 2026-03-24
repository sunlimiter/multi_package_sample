import 'dart:async';

import 'package:flutter/material.dart';

import 'preferences_session_manager.dart';
import 'session_config.dart';
import 'session_listener.dart';

abstract class SessionManager with ChangeNotifier {
  // 单例管理（类似 Kotlin 中 getDefault/init）
  static SessionConfig? _sConfig;
  static SessionManager? _instance;

  static void init(SessionConfig config, {SessionManager? manager}) {
    _sConfig = config;
    _instance = manager ?? PreferencesSessionManager(config);
  }

  static SessionManager get defaultManager {
    if (_sConfig == null || _instance == null) {
      throw StateError('SessionManager not initialized. Call SessionManager.init(...) first.');
    }
    return _instance!;
  }

  final List<SessionStateChangedListener> _listeners = [];

  Future<void> loadData();

  bool isLogin();

  Future<void> clear();

  T? getUser<T>();

  Stream<T?> getUserStream<T>();

  Future<void> setUser<T>(T? user);

  Future<void> setUserToken(String? token);

  String? getUserToken();

  void addSessionStateChangedListener(SessionStateChangedListener l) {
    if (!_listeners.contains(l)) _listeners.add(l);
  }

  void removeSessionStateChangedListener(SessionStateChangedListener l) {
    _listeners.remove(l);
  }

  @protected
  void notifyUserInfoChanged() {
    for (final l in List<SessionStateChangedListener>.from(_listeners)) {
      try {
        l.onUserInfoChanged(this);
      } catch (e, st) {
        debugPrint('listener onUserInfoChanged error: $e\n$st');
      }
    }
    notifyListeners();
  }

  @protected
  void notifyTokenChanged() {
    for (final l in List<SessionStateChangedListener>.from(_listeners)) {
      try {
        l.onTokenInfoChanged(this);
      } catch (e, st) {
        debugPrint('listener onTokenInfoChanged error: $e\n$st');
      }
    }
    notifyListeners();
  }
}
