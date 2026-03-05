// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get login_screen_account_hint => '请输入账号';

  @override
  String get login_screen_forgot_pwd => '忘记密码?';

  @override
  String get login_screen_login => '登录';

  @override
  String get login_screen_other_login_type => '使用其他账号登录';

  @override
  String get login_screen_password_hint => '请输入密码';

  @override
  String get login_screen_title => '欢迎回来';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get login_screen_account_hint => '请输入账号';

  @override
  String get login_screen_forgot_pwd => '忘记密码?';

  @override
  String get login_screen_login => '登录';

  @override
  String get login_screen_other_login_type => '使用其他账号登录';

  @override
  String get login_screen_password_hint => '请输入密码';

  @override
  String get login_screen_title => '欢迎回来';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get login_screen_account_hint => '请输入账号';

  @override
  String get login_screen_forgot_pwd => '忘记密码?';

  @override
  String get login_screen_login => '登录';

  @override
  String get login_screen_other_login_type => '使用其他账号登录';

  @override
  String get login_screen_password_hint => '请输入密码';

  @override
  String get login_screen_title => '欢迎回来';
}
