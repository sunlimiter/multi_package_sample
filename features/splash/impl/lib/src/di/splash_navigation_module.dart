import 'package:common/common.dart';
import 'package:splash_api/splash_api.dart';
import '../ui/splash_screen.dart';

@Named('Splash')
@Injectable(as: IModuleRouter)
class SplashNavigationModule extends IModuleRouter {
  @override
  List<RouteBase> getGlobalRoutes() {
    return [GoRoute(path: SplashRoutes.root, builder: (context, state) => const SplashScreen())];
  }
}
