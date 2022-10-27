import 'package:core/core.dart';
import 'package:user_center/src/di/user_center_injection.dart';
import 'package:user_center/src/router/user_center_router_module.dart';

///author: lty
////Time: 2022/10/25
////Description:

class UserCenterResolver extends FeatureResolver {
  @override
  InjectionModule get injectionModule => UserCenterInjectionModule();

  @override
  RouterModule get routerModule => UserCenterRouterModule();
}
