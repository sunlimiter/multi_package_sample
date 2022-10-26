import 'package:flutter/widgets.dart';

///local: 当前的当前的系统语言设置
///supportedLocales: 为当前应用支持的locale列表，是开发者在MaterialApp中通过supportedLocales属性注册的
Locale? localeResolutionCallback(
  Locale? locale,
  Iterable<Locale> supportedLocales,
) {
  final fullMatch = getSupportedLocaleForLanguageAndCountryCode(supportedLocales, locale);
  if (fullMatch != null) {
    return fullMatch;
  }
  final partialMatch = getSupportedLocaleForLanguageCode(supportedLocales, locale);
  if (partialMatch != null) {
    return partialMatch;
  }

  return supportedLocales.first;
}

Locale? getSupportedLocaleForLanguageAndCountryCode(Iterable<Locale> supportedLocales, Locale? locale) {
  for (final supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale?.languageCode && supportedLocale.countryCode == locale?.countryCode) {
      return supportedLocale;
    }
  }

  return null;
}

Locale? getSupportedLocaleForLanguageCode(Iterable<Locale> supportedLocales, Locale? locale) {
  for (final supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale?.languageCode) {
      return supportedLocale;
    }
  }

  return null;
}
