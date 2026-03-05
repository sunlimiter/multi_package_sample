import 'package:common/common.dart';
import 'package:auth_api/auth_api.dart';
import '../ui/auth_screen.dart';

@Named('Auth')
@Injectable(as: IModuleRouter)
class AuthNavigationModule extends IModuleRouter {
  @override
  List<StatefulShellBranch> getShellBranches() {
    return [];
  }

  @override
  List<RouteBase> getGlobalRoutes() {
    return [GoRoute(path: AuthRoutes.root, builder: (context, state) => const AuthScreen())];
  }
}
