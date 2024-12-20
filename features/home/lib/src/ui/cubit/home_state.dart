import 'package:common_dependencies/common_dependencies.dart';

///author: lty
////Time: 2022/10/25
////Description:
class HomeState extends Equatable {
  const HomeState({
    this.username = '',
  });

  final String username;

  HomeState copyWith({
    FormzSubmissionStatus? status,
    String? message,
    String? username,
  }) {
    return HomeState(
      username: username ?? this.username,
    );
  }

  @override
  List<Object> get props => [
        username,
      ];
}
