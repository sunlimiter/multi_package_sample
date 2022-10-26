import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'result.dart';
import 'http_interceptors.dart';
import 'package:common_dependencies/common_dependencies.dart';

///author: lty
///Time: 2022/05/31
///Description:

abstract class HttpClient {
  Future<ResultData> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<ResultData> post(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  });

  Future<ResultData> upload(
    String url,
    File file, {
    Map<String, dynamic>? headers,
  });

  Future<bool> download(
    String url,
    String savePath, {
    Map<String, dynamic>? headers,
  });

  Future<ResultData> delete(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  });
}

class HttpClientImpl implements HttpClient {
  HttpInterceptors? httpInterceptors;
  late String baseUrl;
  final BuildConfig buildConfig;

  late Dio dio;

  HttpClientImpl(this.buildConfig) {
    httpInterceptors = HttpInterceptors();
    baseUrl = buildConfig.getString('baseUrl')!;

    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
      contentType: Headers.jsonContentType,
    );
    dio = Dio(options);

    _initApiClient();
  }

  Future<void> _initApiClient() async {
    if (httpInterceptors != null) {
      dio.interceptors.add(httpInterceptors!);
      dio.interceptors.add(LogInterceptor(responseBody: true)); //开启请求日志
    }
  }

  @override
  Future<ResultData> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response response = await dio.get(
      url,
      options: Options(
        headers: headers == null ? {} : headers.map(MapEntry.new),
      ),
    );
    return ResultData.fromJson(response.data);
  }

  @override
  Future<ResultData> post(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    Response response = await dio.post(
      url,
      data: body ?? {},
      options: Options(
        headers: headers == null ? {} : headers.map(MapEntry.new),
      ),
    );
    return ResultData.fromJson(response.data);
  }

  @override
  Future<ResultData> upload(
    String url,
    File file, {
    Map<String, dynamic>? headers,
  }) async {
    var formData = FormData.fromMap({'file': await MultipartFile.fromFile(file.path, filename: basename(file.path))});
    Response response = await dio.post(
      url,
      data: formData,
      options: Options(
        headers: headers == null ? {'ACTION': 'api/spider-fileupload/1.0/upload'} : headers.map(MapEntry.new),
      ),
    );
    return ResultData.fromJson(response.data);
  }

  @override
  Future<bool> download(
    String url,
    String savePath, {
    Map<String, dynamic>? headers,
  }) async {
    try {
      var response = await dio.download(url, savePath);
      if (response.data is ResponseBody) {
        var req = response.data as ResponseBody;
        if (req.statusCode == 200) {
          return true;
        } else {
          debugPrint(
            '文件下载失败:statusCode=${req.statusCode} statusMessage=${req.statusMessage}',
          );
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
    return false;
  }

  @override
  Future<ResultData> delete(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
  }) async {
    Response response = await dio.delete(
      url,
      data: body ?? {},
      options: Options(
        headers: headers == null ? {} : headers.map(MapEntry.new),
      ),
    );
    return ResultData.fromJson(response.data);
  }
}
