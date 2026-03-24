import 'package:auth_api/auth_api.dart';
import 'package:common/common.dart';
import 'package:flutter/widgets.dart';

@injectable
class AuthRepository {
  final HttpClient _httpClient;

  AuthRepository(this._httpClient);

  Future<AuthUser?> loginByPwd(String username, String password) async {
    var result = await _httpClient.post('/api/loginByPwd', body: {'userName': username, 'password': password});

    debugPrint('AuthRepository login result: ${result.ok}, error: ${result.error}, data: ${result.result}');

    if (result.ok) {
      final authUser = AuthUser.fromJson(result.result);
      await SessionManager.defaultManager.setUser(authUser);
      await SessionManager.defaultManager.setUserToken(authUser.token);
      return authUser;
    } else {
      throw Exception(result.error?.message ?? 'Login failed');
    }
  }

  Future<AuthUser?> fetchUserInfo() async {
    final result = await _httpClient.get('/api/userInfo');

    if (result.ok) {
      final newUserInfo = UserInfo.fromJson(result.result);
      final currentUser = SessionManager.defaultManager.getUser<AuthUser>();
      if (currentUser != null) {
        final updatedUser = currentUser.copyWith(userInfo: newUserInfo);
        await SessionManager.defaultManager.setUser<AuthUser>(updatedUser);
        return updatedUser;
      } else {
        throw Exception('No session found');
      }
    } else {
      throw Exception(result.error?.message ?? 'Failed to fetch user info');
    }
  }
}
