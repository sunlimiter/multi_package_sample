import 'dart:io';

import 'result.dart';

abstract class HttpClient {
  Future<ResultData> get(String path, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers});

  Future<ResultData> post(String path, {Map<String, dynamic>? body, Map<String, dynamic>? headers});

  Future<ResultData> upload(
    String path,
    File file, {
    Map<String, dynamic>? headers,
    void Function(int count, int total)? onSendProgress,
  });

  Future<ResultData> download(
    String urlPath,
    String savePath, {
    void Function(int count, int total)? onReceiveProgress,
    Map<String, dynamic>? headers,
  });
}
