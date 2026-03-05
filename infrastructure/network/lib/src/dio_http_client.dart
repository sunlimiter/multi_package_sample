import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'http_client.dart';
import 'result.dart';

@LazySingleton(as: HttpClient)
class DioHttpClient implements HttpClient {
  final Dio _dio;

  DioHttpClient(this._dio);

  @override
  Future<ResultData> get(String path, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers}) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: headers != null ? Options(headers: headers) : null,
    );
    return ResultData.fromJson(response.data);
  }

  @override
  Future<ResultData> post(String path, {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    final response = await _dio.post(
      path,
      data: body,
      options: headers != null ? Options(headers: headers) : null,
    );
    debugPrint(
      'POST $path, body: $body, headers: $headers, response: ${response.data},data: ${ResultData.fromJson(response.data)}',
    );
    return ResultData.fromJson(response.data);
  }

  @override
  Future<ResultData> upload(
    String path,
    File file, {
    Map<String, dynamic>? headers,
    void Function(int, int)? onSendProgress,
  }) async {
    final formData = FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});

    final response = await _dio.post(
      path,
      data: formData,
      options: headers != null ? Options(headers: headers) : null,
      onSendProgress: onSendProgress,
    );
    return ResultData.fromJson(response.data);
  }

  @override
  Future<ResultData> download(
    String urlPath,
    String savePath, {
    void Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? headers,
  }) async {
    final response = await _dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      options: headers != null ? Options(headers: headers) : null,
    );

    // Download usually doesn't return the standard API ResultData json,
    // it returns the file content if we don't save it, but since we are saving it,
    // we return a success ResultData wrapper indicating successful download.
    return ResultData(ok: true, result: response.data);
  }
}
