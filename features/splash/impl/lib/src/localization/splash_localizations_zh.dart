// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'splash_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get splash_welcome => '欢迎';

  @override
  String splash_starting_in(int seconds) {
    return '$seconds秒后开始...';
  }
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get splash_welcome => '欢迎';

  @override
  String splash_starting_in(int seconds) {
    return '$seconds秒后开始...';
  }
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get splash_welcome => '歡迎';

  @override
  String splash_starting_in(int seconds) {
    return '$seconds秒後開始...';
  }
}
