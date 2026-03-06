import 'package:auth/src/models/models.dart';
import 'package:common/common.dart';

part 'login_contract.freezed.dart';

@freezed
sealed class LoginIntent with _$LoginIntent implements MviIntent {
  const LoginIntent._();
  const factory LoginIntent.usernameChanged(String username) = _UsernameChanged;
  const factory LoginIntent.passwordChanged(String password) = _PasswordChanged;
  const factory LoginIntent.loginSubmitted() = _LoginSubmitted;
}

@freezed
sealed class LoginState with _$LoginState implements MviViewState {
  const LoginState._();
  const factory LoginState({
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(false) bool isValid,
    @Default('') String message,
    @Default(Username.pure()) Username username,
    @Default(Password.pure()) Password password,
  }) = _LoginState;
}

@freezed
sealed class LoginSingleEvent with _$LoginSingleEvent implements MviSingleEvent {
  const LoginSingleEvent._();
  const factory LoginSingleEvent.loginSuccess() = _LoginSuccess;
  const factory LoginSingleEvent.loginFailure(String error) = _LoginFailure;
}
