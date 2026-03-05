import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:splash/src/localization/splash_localizations.dart';

@Named('Splash')
@Injectable(as: IModuleLocalization)
class SplashLocalizationModule extends IModuleLocalization {
  @override
  LocalizationsDelegate<dynamic> get delegate => AppLocalizations.delegate;
}
