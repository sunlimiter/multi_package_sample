import 'package:common_dependencies/common_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:user_center/src/router/user_center_navigator.dart';
import 'package:user_center/src/ui/mine/mine_cubit.dart';
import 'package:user_center/src/ui/mine/mine_state.dart';

///author: lty
////Time: 2022/10/25
////Description:
class MineScreen extends HookWidget {
  const MineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<MineCubit>();
    final MineState state = useBlocBuilder<MineCubit, MineState>(
      cubit,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.orange.shade900,
                Colors.orange.shade800,
                Colors.orange.shade400,
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(state.username),
            ElevatedButton(
              onPressed: () {
                context.push('${UserRoutes.root}/${UserCenterRoutes.setting}');
              },
              child: const Text('设置'),
            ),
          ],
        ),
      ),
    );
  }
}
