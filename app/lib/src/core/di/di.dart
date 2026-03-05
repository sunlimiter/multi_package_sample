import 'package:app/src/core/di/di.config.dart';

import 'package:common/common.dart';
import 'package:splash/go_splash.dart';
import 'package:auth/go_auth.dart';
import 'package:profile/go_profile.dart';
import 'package:home/go_home.dart';
import 'package:message/go_message.dart';

final getIt = GetIt.instance;

@InjectableInit(
  externalPackageModulesAfter: [
    ExternalModule(NetworkPackageModule),
    ExternalModule(CommonPackageModule),
    ExternalModule(SplashPackageModule),
    ExternalModule(AuthPackageModule),
    ExternalModule(ProfilePackageModule),
    ExternalModule(HomePackageModule),
    ExternalModule(MessagePackageModule),
  ],
)
Future<void> configureDependencies() => getIt.init();
