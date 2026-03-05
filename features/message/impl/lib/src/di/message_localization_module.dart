import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:message/src/localization/message_localizations.dart';

@Named('Message')
@Injectable(as: IModuleLocalization)
class MessageLocalizationModule extends IModuleLocalization {
  @override
  LocalizationsDelegate<dynamic> get delegate => AppLocalizations.delegate;
}
