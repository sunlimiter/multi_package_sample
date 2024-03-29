import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:login/src/di/login_injection_module.dart';
import 'package:login/src/localization/login_localizations.dart';
import 'package:login/src/router/login_router_module.dart';

class LoginResolver implements FeatureResolver {
  @override
  InjectionModule get injectionModule => LoginInjectionModule();

  @override
  LocalizationsDelegate get localeDelegate => AppLocalizations.delegate;

  @override
  RouterModule get routerModule => LoginRouterModule();
}
