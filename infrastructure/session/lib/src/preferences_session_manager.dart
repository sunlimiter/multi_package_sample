import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'session_config.dart';
import 'session_manager.dart';

class PreferencesSessionManager extends SessionManager {
  final SessionConfig _config;
  late final String _keyToken;
  late final String _keyUserJson;

  // in-memory cache
  String? _cachedToken;
  Object? _cachedUser;
  bool _isLoaded = false;

  final StreamController<Object?> _userCtrl = StreamController<Object?>.broadcast();
  final StreamController<String?> _tokenCtrl = StreamController<String?>.broadcast();

  Future<void> _lastWrite = Future.value();

  PreferencesSessionManager(this._config)
    : _keyToken = '${_escape(_config.configName)}_token',
      _keyUserJson = '${_escape(_config.configName)}_user_json';

  static String _escape(String s) => s.replaceAll(RegExp('[^0-9a-zA-Z_]'), '_');

  @override
  Future<void> loadData() async {
    if (_isLoaded) return;

    final prefs = await SharedPreferences.getInstance();

    _cachedToken = prefs.getString(_keyToken);

    final userJson = prefs.getString(_keyUserJson);
    if (userJson != null && userJson.isNotEmpty && _config.userFromJson != null) {
      try {
        _cachedUser = _config.userFromJson!(userJson);
      } catch (e, st) {
        debugPrint('userFromJson failed: $e\n$st');
        _cachedUser = null;
      }
    } else if (userJson != null && userJson.isNotEmpty) {
      // fallback: decode to Map
      try {
        _cachedUser = jsonDecode(userJson);
      } catch (e) {
        _cachedUser = null;
      }
    } else {
      _cachedUser = null;
    }

    // push initial values to streams
    _tokenCtrl.add(_cachedToken);
    _userCtrl.add(_cachedUser);

    _isLoaded = true;
  }

  @override
  bool isLogin() {
    return _cachedToken != null && _cachedToken!.isNotEmpty;
  }

  @override
  Future<void> clear() async {
    _cachedToken = null;
    _cachedUser = null;

    _lastWrite = _lastWrite.then((_) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyUserJson);
      await prefs.remove(_keyToken);
    });

    _tokenCtrl.add(null);
    _userCtrl.add(null);

    notifyTokenChanged();
    notifyUserInfoChanged();

    await _lastWrite;
  }

  @override
  T? getUser<T>() {
    return _cachedUser as T?;
  }

  @override
  Stream<T?> getUserStream<T>() {
    if (!_isLoaded) {
      loadData();
    }
    return _userCtrl.stream.map<T?>((dynamic e) => e as T?);
  }

  @override
  Future<void> setUser<T>(T? user) async {
    _cachedUser = user;

    _userCtrl.add(_cachedUser);
    notifyUserInfoChanged();

    _lastWrite = _lastWrite.then((_) async {
      final prefs = await SharedPreferences.getInstance();
      if (user == null) {
        await prefs.remove(_keyUserJson);
      } else {
        try {
          final json = (_config.userToJson != null) ? _config.userToJson!(user as Object?) : jsonEncode(user);
          await prefs.setString(_keyUserJson, json);
        } catch (e, st) {
          debugPrint('setUser serialization error: $e\n$st');
        }
      }
    });

    await _lastWrite;
  }

  @override
  Future<void> setUserToken(String? token) async {
    if (_cachedToken == token) return;

    _cachedToken = token;
    _tokenCtrl.add(_cachedToken);
    notifyTokenChanged();

    _lastWrite = _lastWrite.then((_) async {
      final prefs = await SharedPreferences.getInstance();
      if (token == null || token.isEmpty) {
        await prefs.remove(_keyToken);
      } else {
        await prefs.setString(_keyToken, token);
      }
    });

    await _lastWrite;
  }

  @override
  String? getUserToken() => _cachedToken;
}
