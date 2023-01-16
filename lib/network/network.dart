import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_core/caches/profiles.dart';
import 'package:flutter_core/network/dio_network.dart' as dio_network;
import 'package:sample/model/api_services.dart';

part 'interceptors.dart';

Future get(String host, String path,
    {Map<String, String>? headers,
    CancelToken? cancelToken,
    Map<String, dynamic>? params,
    Function(Response res)? customParser}) {
  return dio_network.get(host, path,
      headers: headers,
      cancelToken: cancelToken,
      params: params,
      customInterceptors: interceptors,
      parser: customParser ?? ApiServices.jsonParser);
}

Future post(String host, String path, Map<String, dynamic> body,
    {Map<String, String>? headers,
    CancelToken? cancelToken,
    Function(Response res)? customParser}) {
  return dio_network.post(host, path, body,
      headers: headers,
      cancelToken: cancelToken,
      customInterceptors: interceptors,
      parser: customParser ?? ApiServices.jsonParser);
}

Future<File> download(
  String url,
  String savePath, {
  CancelToken? cancelToken,
  ProgressCallback? onReceiveProgress,
}) {
  return dio_network.download(url, savePath,
      cancelToken: cancelToken, onReceiveProgress: onReceiveProgress);
}
