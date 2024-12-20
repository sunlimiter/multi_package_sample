import 'package:common_dependencies/common_dependencies.dart';

///author: lty
///Time: 2022/06/02
///Description:
enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure([super.value = '']) : super.pure();
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String? value) {
    return (value != null && value.isNotEmpty) ? null : PasswordValidationError.empty;
  }
}
