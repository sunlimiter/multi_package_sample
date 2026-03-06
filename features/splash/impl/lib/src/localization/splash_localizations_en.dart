// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'splash_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get splash_welcome => 'WELCOME';

  @override
  String splash_starting_in(int seconds) {
    return 'Starting in ${seconds}s...';
  }
}
