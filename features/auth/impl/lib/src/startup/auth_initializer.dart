import 'dart:convert';
import 'package:common/common.dart';
import 'package:auth_api/auth_api.dart';

@Named('Auth')
@Injectable(as: AppInitializer)
class AuthInitializer extends AppInitializer {
  @override
  Future<void> initialize() async {
    SessionManager.init(
      SessionConfig(
        configName: 'app_session',
        userFromJson: (jsonString) {
          if (jsonString.isEmpty) return null;
          try {
            return AuthUser.fromJson(jsonDecode(jsonString));
          } catch (e) {
            return null;
          }
        },
        userToJson: (user) {
          if (user == null || user is! AuthUser) return '';
          return jsonEncode(user.toJson());
        },
      ),
    );
    await SessionManager.defaultManager.loadData();
  }
}
