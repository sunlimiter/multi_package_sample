/// token : "CADB37AE5E20433FB61B2454CFE050D2"
/// userInfo : {"id":5151410422526,"mobile":"13100009988","name":"ww","userId":1426478759}
/// yxToken : "09e4386db176e2ed2318d95068ddc7ff"

class UserModel {
  UserModel({
    String? token,
    UserInfo? userInfo,
    String? yxToken,
  }) {
    _token = token;
    _userInfo = userInfo;
    _yxToken = yxToken;
  }

  UserModel.fromJson(dynamic json) {
    _token = json['token'];
    _userInfo = json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
    _yxToken = json['yxToken'];
  }

  String? _token;
  UserInfo? _userInfo;
  String? _yxToken;

  UserModel copyWith({
    String? token,
    UserInfo? userInfo,
    String? yxToken,
  }) =>
      UserModel(
        token: token ?? _token,
        userInfo: userInfo ?? _userInfo,
        yxToken: yxToken ?? _yxToken,
      );

  String? get token => _token;

  UserInfo? get userInfo => _userInfo;

  String? get yxToken => _yxToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    if (_userInfo != null) {
      map['userInfo'] = _userInfo?.toJson();
    }
    map['yxToken'] = _yxToken;
    return map;
  }
}

/// id : 5151410422526
/// mobile : "13100009988"
/// name : "ww"
/// userId : 1426478759

class UserInfo {
  UserInfo({
    num? id,
    String? mobile,
    String? name,
    num? userId,
  }) {
    _id = id;
    _mobile = mobile;
    _name = name;
    _userId = userId;
  }

  UserInfo.fromJson(dynamic json) {
    _id = json['id'];
    _mobile = json['mobile'];
    _name = json['name'];
    _userId = json['userId'];
  }

  num? _id;
  String? _mobile;
  String? _name;
  num? _userId;

  UserInfo copyWith({
    num? id,
    String? mobile,
    String? name,
    num? userId,
  }) =>
      UserInfo(
        id: id ?? _id,
        mobile: mobile ?? _mobile,
        name: name ?? _name,
        userId: userId ?? _userId,
      );

  num? get id => _id;

  String? get mobile => _mobile;

  String? get name => _name;

  num? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['mobile'] = _mobile;
    map['name'] = _name;
    map['userId'] = _userId;
    return map;
  }
}
