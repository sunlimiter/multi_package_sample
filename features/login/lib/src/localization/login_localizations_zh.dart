import 'login_localizations.dart';

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
