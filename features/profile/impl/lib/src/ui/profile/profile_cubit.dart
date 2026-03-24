import 'package:auth_api/auth_api.dart';
import 'package:common/common.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final IAuthService _authService;

  ProfileCubit(this._authService) : super(const ProfileState());

  Future<void> fetchUserInfo() async {
    try {
      emit(state.copyWith(isLoading: true));
      final updatedUser = await _authService.refreshUserInfo();
      if (updatedUser != null) {
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false, error: 'User info update returned null without error'));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
