import 'package:common/common.dart';
import 'package:profile_api/profile_api.dart';
import '../ui/profile/profile_page.dart';
import '../ui/settings/settings_page.dart';

@Named('Profile')
@Injectable(as: IModuleRouter)
class ProfileNavigationModule extends IModuleRouter {
  @override
  int get routerIndex => 2;

  @override
  List<StatefulShellBranch> getShellBranches() {
    return [
      StatefulShellBranch(
        routes: [GoRoute(path: ProfileRoutes.root, builder: (context, state) => const ProfilePage())],
      ),
    ];
  }

  @override
  List<RouteBase> getGlobalRoutes() {
    return [GoRoute(path: ProfileRoutes.settings, builder: (context, state) => const SettingsPage())];
  }
}
