import 'package:common/common.dart';

import '../repository/{{name}}_repository.dart';
import '{{name}}_contract.dart';

@injectable
class {{name.pascalCase()}}Cubit extends BaseMviCubit<{{name.pascalCase()}}Intent, {{name.pascalCase()}}State, {{name.pascalCase()}}SingleEvent> {
  final {{name.pascalCase()}}Repository _repository;

  {{name.pascalCase()}}Cubit(this._repository) : super(const {{name.pascalCase()}}State());

  @override
  void onIntent({{name.pascalCase()}}Intent intent) {
    intent.when(
      initial: _onInitial,
    );
  }

  void _onInitial() {
    // Handle initial intent
    emit(state.copyWith(isLoading: true));
    
    // Example repository call:
    // final data = await _repository.fetchData();
    // emit(state.copyWith(isLoading: false));
  }
}
