import 'package:common/common.dart';
import 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  Future<void> logout() async {
    try {
      emit(state.copyWith(isLoggingOut: true));
      await SessionManager.defaultManager.clear();
      // GoRouter refreshListenable handles navigation
    } catch (e) {
      emit(state.copyWith(isLoggingOut: false, error: e.toString()));
    }
  }
}
