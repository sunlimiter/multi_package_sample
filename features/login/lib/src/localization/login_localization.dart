import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class LoginLocalization extends BaseLocalization {
  LoginLocalization({
    required this.appLocale,
    required this.appPathFunction,
  }) : super(appPathFunction: appPathFunction, locale: appLocale);
  @override
  // ignore: overridden_fields
  final String Function(Locale locale) appPathFunction;
  final Locale appLocale;

  static LoginLocalization? of(BuildContext context) => Localizations.of<LoginLocalization>(context, LoginLocalization);

  String get title {
    return tr('login_screen.title');
  }

  String get login {
    return tr('login_screen.login');
  }

  String get forgotPwd {
    return tr('login_screen.forgot_pwd');
  }

  String get accountHint {
    return tr('login_screen.account_hint');
  }

  String get passwordHint {
    return tr('login_screen.password_hint');
  }

  String get otherLoginType {
    return tr('login_screen.other_login_type');
  }
}

class LoginLocalizationDelegate extends LocalizationsDelegate<LoginLocalization> {
  LoginLocalizationDelegate({
    required this.supportedLocales,
    required this.getPathFunction,
    this.debugLogs = true,
  });

  final List<Locale> supportedLocales;

  final String Function(Locale locale) getPathFunction;

  Locale? locale;

  final bool debugLogs;

  @override
  bool isSupported(Locale locale) => getSupportedLocaleForLanguageCode(supportedLocales, locale) != null;

  @override
  Future<LoginLocalization> load(Locale locale) async {
    this.locale = locale;
    final localization = LoginLocalization(
      appLocale: locale,
      appPathFunction: getPathFunction,
    );

    await localization.load();

    return localization;
  }

  @override
  bool shouldReload(LoginLocalizationDelegate old) => old.locale != locale;
}
