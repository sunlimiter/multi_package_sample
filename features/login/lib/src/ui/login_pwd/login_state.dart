import 'package:common_dependencies/common_dependencies.dart';
import 'package:login/src/models/models.dart';

///author: lty
///Time: 2022/06/02
///Description:
class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.message = '',
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  final FormzSubmissionStatus status;
  final bool isValid;
  final String message;
  final Username username;
  final Password password;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    bool? isValid,
    String? message,
    Username? username,
    Password? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
