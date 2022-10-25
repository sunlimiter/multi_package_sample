import 'dart:async';

import 'package:core/core.dart';
import 'package:network/network.dart' as network;

/// Register here all the third party libraries so they can be provided
/// for the rest of the packages.
class AppLibraryModule implements InjectionModule {
  @override
  FutureOr<void> registerDependencies({
    required Injector injector,
    required BuildConfig buildConfig,
  }) async {
    injector.registerSingleton<network.HttpClient>(network.HttpClientImpl(buildConfig));
  }
}
