import 'package:go_router/go_router.dart';

abstract class IModuleRouter {
  /// 排序Index，用于在聚合 Router 时决定前后顺序
  int get routerIndex => 0;

  /// 返回需要在壳内部显示的分支
  /// 每一个 Branch 代表 BottomNavigationBar 的一个 Tab
  List<StatefulShellBranch> getShellBranches() => [];

  /// 返回全屏路由（Splash, Login, 各种详情页）
  List<RouteBase> getGlobalRoutes() => [];
}
