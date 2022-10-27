import 'package:common_dependencies/common_dependencies.dart';

///author: lty
////Time: 2022/10/25
////Description:

class MineState extends Equatable {
  const MineState({
    this.username = '',
  });

  final String username;

  MineState copyWith({
    FormzStatus? status,
    String? message,
    String? username,
  }) {
    return MineState(
      username: username ?? this.username,
    );
  }

  @override
  List<Object> get props => [
        username,
      ];
}
