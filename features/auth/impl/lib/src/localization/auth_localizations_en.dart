// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'auth_localizations.dart';

// ignore_for_file: type=lint

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

  @override
  String get login_screen_username_error => 'Please enter a valid phone number';

  @override
  String get login_screen_password_error => 'Please enter a valid password';

  @override
  String get login_screen_facebook => 'Facebook';

  @override
  String get login_screen_github => 'Github';

  @override
  String get login_screen_error_failed => 'Login failed';

  @override
  String get login_screen_success => 'Login successful';
}
