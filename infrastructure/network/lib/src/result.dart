///author: lty
///Time: 2020/4/2
///Description:返回结果基类
class ResultData {
  static Error GlobleError = Error(code: "-1", message: "网络异常，请检查网络连接");

  late bool ok;
  Error? error;
  dynamic result;

  ///标识数据是否为缓存
  bool? isCache = false;

  ResultData({this.result, required this.ok, this.error, this.isCache});

  ResultData.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    ok = json['ok'];
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
    if (!ok && error == null) {
      error = GlobleError;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['ok'] = this.ok;
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    return data;
  }
}

class Error {
  String? message;
  String? code;

  Error({this.message, this.code});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}

class Result {
  String? message;
  String? code;
  dynamic data;

  Result({this.message, this.code, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    data['data'] = this.data;
    return data;
  }
}
