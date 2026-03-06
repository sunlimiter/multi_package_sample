import 'package:auth_api/src/models/auth_user.dart';

abstract class IAuthService {
  /// Refreshes the user info and updates the SessionManager.
  /// Returns the updated [AuthUser] if successful.
  Future<AuthUser?> refreshUserInfo();
}
