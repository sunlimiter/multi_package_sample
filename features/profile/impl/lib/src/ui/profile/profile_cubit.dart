import 'package:auth_api/auth_api.dart';
import 'package:common/common.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final HttpClient _httpClient;

  ProfileCubit(this._httpClient) : super(const ProfileState());

  Future<void> fetchUserInfo() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      final resultData = await _httpClient.get('/api/userInfo');

      if (resultData.ok) {
        final newUserInfo = UserInfo.fromJson(resultData.result);
        final currentUser = SessionManager.defaultManager.getUser<AuthUser>();
        if (currentUser != null) {
          final updatedUser = currentUser.copyWith(userInfo: newUserInfo);
          await SessionManager.defaultManager.setUser<AuthUser>(updatedUser);
          emit(state.copyWith(isLoading: false));
        } else {
          emit(state.copyWith(isLoading: false, error: 'No session found'));
        }
      } else {
        emit(state.copyWith(isLoading: false, error: resultData.error?.message ?? 'Failed to fetch user info'));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
