import 'dart:async';

import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class LocaleState {
  final Locale locale;

  LocaleState(this.locale);
}

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(const Locale('en', 'US'))) {
    _localeSubscription = _localeRepository.locale.listen(
      _mapLocaleChangedToState,
    );
  }

  final LocaleRepository _localeRepository = AppInjector.I.get();

  StreamSubscription<Locale>? _localeSubscription;

  @override
  Future<void> close() {
    _localeSubscription?.cancel();
    _localeRepository.dispose();
    return super.close();
  }

  Future<void> _mapLocaleChangedToState(
    Locale newLocale,
  ) async {
    emit(LocaleState(newLocale));
  }
}
