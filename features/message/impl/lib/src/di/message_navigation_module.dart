import 'package:common/common.dart';
import 'package:message_api/message_api.dart';
import '../ui/message_screen.dart';

@Named('Message')
@Injectable(as: IModuleRouter)
class MessageNavigationModule extends IModuleRouter {
  @override
  int get routerIndex => 1;

  @override
  List<StatefulShellBranch> getShellBranches() {
    return [
      StatefulShellBranch(
        routes: [GoRoute(path: MessageRoutes.root, builder: (context, state) => const MessageScreen())],
      ),
    ];
  }

  @override
  List<RouteBase> getGlobalRoutes() {
    return [];
  }
}
