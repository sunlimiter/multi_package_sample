import 'package:common/common.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:{{name}}/src/localization/{{name}}_localizations.dart';
import 'package:{{name}}_api/{{name}}_api.dart';

@Named('{{name.pascalCase()}}')
@Injectable(as: IModuleLocalization)
class {{name.pascalCase()}}LocalizationModule extends IModuleLocalization {
  @override
  LocalizationsDelegate<dynamic> get delegate => AppLocalizations.delegate;
}
