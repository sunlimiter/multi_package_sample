import 'package:common_dependencies/common_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:user_center/src/ui/mine/mine_cubit.dart';
import 'package:user_center/src/ui/mine/mine_state.dart';

///author: lty
////Time: 2022/10/25
////Description:
class MineScreen extends HookWidget {
  const MineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _cubit = useBloc<MineCubit>();
    final MineState _state = useBlocBuilder<MineCubit, MineState>(
      _cubit,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(_state.username),
          ],
        ),
      ),
    );
  }
}
