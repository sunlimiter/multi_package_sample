// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) =>
    AuthUser(token: json['token'] as String, userInfo: UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>));

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
  'token': instance.token,
  'userInfo': instance.userInfo.toJson(),
};

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) =>
    UserInfo(userId: json['userId'] as String, userName: json['userName'] as String, avatar: json['avatar'] as String?);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'userId': instance.userId,
  'userName': instance.userName,
  'avatar': instance.avatar,
};
