import 'dart:async';

import 'package:common_dependencies/common_dependencies.dart';
import 'package:flutter/material.dart';

abstract class LocaleRepository {
  Future<Locale?> getLocale();

  Future<void> changeLocale(Locale locale);

  void dispose();
  Stream<Locale> get locale;
}

class ILocaleRepository implements LocaleRepository {
  final _controller = StreamController<Locale>();

  Locale? _locale;

  @override
  Stream<Locale> get locale async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var localeString = prefs.getString('locale');
    if (localeString != null) {
      yield Locale.fromSubtags(languageCode: localeString.split('_')[0], countryCode: localeString.split('_')[1]);
    }
    yield* _controller.stream;
  }

  @override
  Future<void> changeLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.toString());
    _locale = locale;
    _controller.add(locale);
  }

  @override
  void dispose() => _controller.close();

  @override
  Future<Locale?> getLocale() async {
    if (_locale != null) return _locale;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var localeString = prefs.getString('locale');
    if (localeString != null) {
      _locale = Locale.fromSubtags(languageCode: localeString.split('_')[0], countryCode: localeString.split('_')[1]);
    }
    return _locale;
  }
}
