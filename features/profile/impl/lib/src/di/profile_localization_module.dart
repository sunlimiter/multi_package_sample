import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:profile/src/localization/profile_localizations.dart';

@Named('Profile')
@Injectable(as: IModuleLocalization)
class ProfileLocalizationModule extends IModuleLocalization {
  @override
  LocalizationsDelegate<dynamic> get delegate => AppLocalizations.delegate;
}
