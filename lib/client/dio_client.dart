import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hungry_hub/utils/constant/api_constants.dart';

class DioClient {
  static Dio? _dioClient;

  static Dio getClient() {
    if (_dioClient == null) {
      initClient();
    }
    return _dioClient!;
  }

  static Future<Dio?> initClient() async {
    _dioClient = Dio(
      BaseOptions(
          baseUrl: APIConstant.BASE_URL,
          connectTimeout: const Duration(milliseconds: APIConstant.TIMEOUT),
          receiveTimeout: const Duration(milliseconds: APIConstant.TIMEOUT),
          validateStatus: (status) {
            return status! <= 500 && status != 401;
          },
          headers: {
            "Accept": "application/json",
            "Platform": Platform.isAndroid ? "Android" : "iOS",
          }),
    );

    _dioClient?.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (error, handler) async {
        handler.next(error);
      },
    ));
    return _dioClient;
  }
}
