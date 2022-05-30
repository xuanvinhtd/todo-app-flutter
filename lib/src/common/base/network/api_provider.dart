import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:getx_todo/src/app/config/app_constant.dart';
import 'package:getx_todo/src/app/config/app_env.dart';
import 'package:getx_todo/src/common/base/network/api_interceptor.dart';
import 'package:getx_todo/src/common/base/network/api_stub.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class APIProvider {
  late Dio _dio;

  APIProvider(AppEnv env, {bool isStub = false}) {
    final dioOptions = BaseOptions(contentType: AppConstant.CONTENT_TYPE);
    dioOptions.connectTimeout = AppConstant.TIME_OUT;
    dioOptions.receiveTimeout = AppConstant.TIME_OUT;
    dioOptions.receiveTimeout = AppConstant.TIME_OUT;
    dioOptions.baseUrl = env.baseUrl;
    dioOptions.responseType = ResponseType.json;

    _dio = Dio(dioOptions);
    _dio.interceptors.add(ApiInterceptor());

    if (isStub) {
      _dio.httpClientAdapter = StubDio();
    }

    if (env.isDev || kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      ));
    }
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? params,
    CancelToken? cancelToken,
  }) async {
    final response = await _dio.get(path, queryParameters: params, cancelToken: cancelToken);
    throwIfNoSuccess(response);
    if (response.data is String) {
      return jsonDecode(response.data.toString());
    } else {
      return response.data;
    }
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? params, CancelToken? cancelToken}) async {
    final response = await _dio.post(path, data: params, cancelToken: cancelToken);
    throwIfNoSuccess(response);

    if (response.data is String) {
      return jsonDecode(response.data.toString());
    } else {
      return response.data;
    }
  }

  Future<dynamic> put(String path, {Map<String, dynamic>? params, CancelToken? cancelToken}) async {
    final response = await _dio.put(path, data: params, cancelToken: cancelToken);
    throwIfNoSuccess(response);

    if (response.data is String) {
      return jsonDecode(response.data.toString());
    } else {
      return response.data;
    }
  }

  Future<dynamic> postFromData(String path, {FormData? formData, int len = 0, CancelToken? cancelToken}) async {
    final response = await _dio.post(
      path,
      data: formData,
      cancelToken: cancelToken,
      onSendProgress: (received, total) {
        if (total != -1) {
          if (kDebugMode) {
            print((received / total * 100).toStringAsFixed(0) + '%');
          }
        }
      },
    );
    throwIfNoSuccess(response);

    if (response.data is String) {
      return jsonDecode(response.data.toString());
    } else {
      return response.data;
    }
  }

  Future<dynamic> putFromData(String path, {FormData? formData, int len = 0, CancelToken? cancelToken}) async {
    final response = await _dio.put(
      path,
      data: formData,
      cancelToken: cancelToken,
      onSendProgress: (received, total) {
        if (total != -1) {
          if (kDebugMode) {
            print((received / total * 100).toStringAsFixed(0) + '%');
          }
        }
      },
    );
    throwIfNoSuccess(response);

    if (response.data is String) {
      return jsonDecode(response.data.toString());
    } else {
      return response.data;
    }
  }

  void throwIfNoSuccess(Response response) {
    if (response.statusCode == null) throw HttpException(response);
    if (response.statusCode! < 200 || response.statusCode! > 299) {
      throw HttpException(response);
    }
  }
}

class HttpException implements Exception {
  Response response;

  HttpException(this.response);
}
