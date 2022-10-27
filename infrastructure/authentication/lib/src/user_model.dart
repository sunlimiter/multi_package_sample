class UserModel {
  String? accessToken;
  UserInfo? userInfo;

  UserModel({this.accessToken, this.userInfo});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        accessToken: json['access_token'] as String?,
        userInfo: json['user_info'] == null ? null : UserInfo.fromJson(json['user_info'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
        'user_info': userInfo?.toJson(),
      };
}

class UserInfo {
  String? name;
  String? mobile;
  String? userId;

  UserInfo({this.name, this.mobile, this.userId});

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        name: json['name'] as String?,
        mobile: json['mobile'] as String?,
        userId: json['userId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'mobile': mobile,
        'userId': userId,
      };
}
