import 'package:common_dependencies/common_dependencies.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:user_center/src/ui/mine/mine_state.dart';

///author: lty
////Time: 2022/10/25
////Description: 

class MineCubit extends Cubit<MineState> {
  MineCubit() : super(const MineState()) {
    init();
  }
  late String userInfo;

  final AuthenticationRepository _authenticationRepository = AppInjector.I.get();

  Future<void> init() async {
    var user = await _authenticationRepository.getUser();
    debugPrint('${user?.userModel?.toJson()}');
    emit(state.copyWith(username: '${user?.userModel?.toJson()}'));
  }

  void logout() {
    _authenticationRepository.logOut();
  }
}
