import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 1. 意图抽象 (Intent abstraction)
abstract class MviIntent {}

/// 2. 状态抽象 (State abstraction)
/// (建议实现 copyWith 方法的通用性，结合 freezed 使用可以自动生成)
abstract class MviViewState {
  const MviViewState();
}

/// 3. 一次性事件抽象 (Single event abstraction)
abstract class MviSingleEvent {}

/// 基础的 MVI Cubit 实现
abstract class BaseMviCubit<I extends MviIntent, S extends MviViewState, E extends MviSingleEvent> extends Cubit<S> {
  final _effectController = StreamController<E>.broadcast();

  Stream<E> get effectStream => _effectController.stream;

  BaseMviCubit(S initialState) : super(initialState);

  /// 严谨的 intent 分发
  void onIntent(I intent);

  /// 发送一次性事件
  void emitEffect(E effect) {
    if (!_effectController.isClosed) {
      _effectController.add(effect);
    }
  }

  @override
  Future<void> close() {
    _effectController.close();
    return super.close();
  }
}
