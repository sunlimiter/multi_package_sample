import 'package:common/common.dart';
import 'package:common/common.dart';
import 'package:{{name}}_api/{{name}}_api.dart';
import '../ui/{{name}}_screen.dart';

@Named('{{name.pascalCase()}}')
@Injectable(as: IModuleRouter)
class {{name.pascalCase()}}NavigationModule extends IModuleRouter {
  @override
  List<StatefulShellBranch> getShellBranches() {
    return [];
  }

  @override
  List<RouteBase> getGlobalRoutes() {
    return [
      GoRoute(
        path: {{name.pascalCase()}}Routes.root,
        builder: (context, state) => const {{name.pascalCase()}}Screen(),
      ),
    ];
  }
}
