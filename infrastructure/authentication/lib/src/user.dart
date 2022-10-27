///author: lty
///Time: 2022/06/01
///Description:
import 'package:authentication/src/user_model.dart';
import 'package:common_dependencies/common_dependencies.dart';

class User extends Equatable {
  final UserModel? userModel;

  const User({this.userModel});

  @override
  List<Object?> get props => [userModel?.userInfo?.userId, userModel?.accessToken];

  static const empty = User();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(userModel: UserModel.fromJson(json));
  }

  Map<String, dynamic>? toJson() {
    return userModel?.toJson();
  }
}
