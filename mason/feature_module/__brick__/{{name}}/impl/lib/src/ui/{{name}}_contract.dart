import 'package:common/common.dart';

part '{{name}}_contract.freezed.dart';

@freezed
sealed class {{name.pascalCase()}}Intent with _${{name.pascalCase()}}Intent implements MviIntent {
  const {{name.pascalCase()}}Intent._();
  const factory {{name.pascalCase()}}Intent.initial() = _Initial;
}

@freezed
sealed class {{name.pascalCase()}}State with _${{name.pascalCase()}}State implements MviViewState {
  const {{name.pascalCase()}}State._();
  const factory {{name.pascalCase()}}State({
    @Default(false) bool isLoading,
  }) = _{{name.pascalCase()}}State;
}

@freezed
sealed class {{name.pascalCase()}}SingleEvent with _${{name.pascalCase()}}SingleEvent implements MviSingleEvent {
  const {{name.pascalCase()}}SingleEvent._();
  const factory {{name.pascalCase()}}SingleEvent.showError(String message) = _ShowError;
}
