import 'package:json_annotation/json_annotation.dart';

part 'auth_user.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthUser {
  final String token;
  final UserInfo userInfo;

  AuthUser({required this.token, required this.userInfo});

  AuthUser copyWith({String? token, UserInfo? userInfo}) {
    return AuthUser(token: token ?? this.token, userInfo: userInfo ?? this.userInfo);
  }

  factory AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}

@JsonSerializable()
class UserInfo {
  final String userId;
  final String userName;
  final String? avatar;

  UserInfo({required this.userId, required this.userName, this.avatar});

  UserInfo copyWith({String? userId, String? userName, String? avatar}) {
    return UserInfo(userId: userId ?? this.userId, userName: userName ?? this.userName, avatar: avatar ?? this.avatar);
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
