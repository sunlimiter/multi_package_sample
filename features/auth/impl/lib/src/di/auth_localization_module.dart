import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:auth/src/localization/auth_localizations.dart';

@Named('Auth')
@Injectable(as: IModuleLocalization)
class AuthLocalizationModule extends IModuleLocalization {
  @override
  LocalizationsDelegate<dynamic> get delegate => AppLocalizations.delegate;
}
