import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:home/src/localization/home_localizations.dart';

@Named('Home')
@Injectable(as: IModuleLocalization)
class HomeLocalizationModule extends IModuleLocalization {
  @override
  LocalizationsDelegate<dynamic> get delegate => AppLocalizations.delegate;
}
