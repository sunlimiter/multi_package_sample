import 'package:auth_api/auth_api.dart';
import 'package:common/common.dart';

import '../repository/auth_repository.dart';

@LazySingleton(as: IAuthService)
class AuthServiceImpl implements IAuthService {
  final AuthRepository _repository;

  AuthServiceImpl(this._repository);

  @override
  Future<AuthUser?> refreshUserInfo() async {
    return await _repository.fetchUserInfo();
  }
}
