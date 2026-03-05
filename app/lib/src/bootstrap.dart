import 'dart:async';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'core/di/di.dart';
import 'presentation/app.dart';

Future<void> bootstrap() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await configureDependencies();

      final initializers = getIt.getAll<AppInitializer>();
      initializers.forEach(StartupManager.register);
      await StartupManager.init();

      final moduleRouters = getIt.getAll<IModuleRouter>().toList()
        ..sort((a, b) => a.routerIndex.compareTo(b.routerIndex));
      final moduleLocalizations = getIt.getAll<IModuleLocalization>().toList();

      final allRoutes = moduleRouters.expand((module) => module.getGlobalRoutes()).toList();
      final shellBranches = moduleRouters.expand((module) => module.getShellBranches()).toList();
      final localizationsDelegates = moduleLocalizations.map((e) => e.delegate).toList();

      runApp(
        HookedBlocConfigProvider(
          injector: () =>
              <T extends Object>() => getIt.get<T>(),
          child: MyApp(routes: allRoutes, shellBranches: shellBranches, localizationsDelegates: localizationsDelegates),
        ),
      );
    },
    (error, stackTrace) {
      debugPrint('runZonedGuarded error: $error\n$stackTrace');
    },
  );
}
