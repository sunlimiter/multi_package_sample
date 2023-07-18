import 'login_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login_screen_account_hint => 'Please enter account';

  @override
  String get login_screen_forgot_pwd => 'Forgot Password?';

  @override
  String get login_screen_login => 'Login';

  @override
  String get login_screen_other_login_type => 'Continue with social media';

  @override
  String get login_screen_password_hint => 'Please enter password';

  @override
  String get login_screen_title => 'Welcome Back';
}
