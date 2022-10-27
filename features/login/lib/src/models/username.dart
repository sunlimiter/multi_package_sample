import 'package:common_dependencies/common_dependencies.dart';

///author: lty
///Time: 2022/06/02
///Description:

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  static final _emailRegExp = RegExp(
    r'^1(3\d|4[5-9]|5[0-35-9]|6[2567]|7[0-8]|8\d|9[0-35-9])\d{8}$',
  );

  @override
  UsernameValidationError? validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : UsernameValidationError.empty;
  }
}
