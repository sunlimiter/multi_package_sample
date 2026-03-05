import 'package:common/common.dart';
import 'package:home_api/home_api.dart';
import '../ui/home_screen.dart';

@Named('Home')
@Injectable(as: IModuleRouter)
class HomeNavigationModule extends IModuleRouter {
  @override
  int get routerIndex => 0;

  @override
  List<StatefulShellBranch> getShellBranches() {
    return [
      StatefulShellBranch(
        routes: [GoRoute(path: HomeRoutes.root, builder: (context, state) => const HomeScreen())],
      ),
    ];
  }

  @override
  List<RouteBase> getGlobalRoutes() {
    return [];
  }
}
