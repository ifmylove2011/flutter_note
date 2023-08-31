import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Config {
  static const NOTE_URL = "http://192.168.21.103:5055";
  static const JUHE_URL = "http://apis.juhe.cn";
  static const JUHE_V_URL = "http://v.juhe.cn";
  static const TIME_OUT = 10000;
}

class JuheHolder {
  late Dio dio;

  static JuheHolder? _instance;
  static JuheHolder get() {
    return _instance ??= JuheHolder();
  }

  JuheHolder() {
    dio = Dio();

    dio.options = BaseOptions(
        baseUrl: Config.JUHE_URL,
        contentType: 'application/x-www-form-urlencoded',
        headers: {});

    /// 请求拦截器 and 响应拦截机 and 错误处理
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      debugPrint("\n================== 请求数据 ==========================");
      debugPrint("url = ${options.uri.toString()}");
      debugPrint("headers = ${options.headers}");
      debugPrint("params = ${options.data}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      debugPrint("\n================== 响应数据 ==========================");
      debugPrint("code = ${response.statusCode}");
      // debugPrint("data = ${response.data}");
      debugPrint("\n");
      handler.next(response);
    }, onError: (DioException e, handler) {
      debugPrint("\n================== 错误响应数据 ======================");
      debugPrint("type = ${e.type}");
      debugPrint("message = ${e.message}");
      debugPrint("\n");
      return handler.next(e);
    }));
  }
}

class JuheVHolder {
  late Dio dio;

  static JuheVHolder? _instance;
  static JuheVHolder get() {
    return _instance ??= JuheVHolder();
  }

  JuheVHolder() {
    dio = Dio();

    dio.options = BaseOptions(
        baseUrl: Config.JUHE_V_URL,
        contentType: 'application/x-www-form-urlencoded',
        headers: {});

    /// 请求拦截器 and 响应拦截机 and 错误处理
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      debugPrint("\n================== 请求数据 ==========================");
      debugPrint("url = ${options.uri.toString()}");
      debugPrint("headers = ${options.headers}");
      debugPrint("params = ${options.data}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      debugPrint("\n================== 响应数据 ==========================");
      debugPrint("code = ${response.statusCode}");
      // debugPrint("data = ${response.data}");
      debugPrint("\n");
      handler.next(response);
    }, onError: (DioException e, handler) {
      debugPrint("\n================== 错误响应数据 ======================");
      debugPrint("type = ${e.type}");
      debugPrint("message = ${e.message}");
      debugPrint("\n");
      return handler.next(e);
    }));
  }
}

class DioHolder {
  late Dio dio;

  static DioHolder? _instance;
  static DioHolder get() {
    return _instance ??= DioHolder();
  }

  DioHolder() {
    dio = Dio();

    dio.options = BaseOptions(
        baseUrl: Config.NOTE_URL,
        connectTimeout: const Duration(milliseconds: Config.TIME_OUT),
        sendTimeout: const Duration(milliseconds: Config.TIME_OUT),
        receiveTimeout: const Duration(milliseconds: Config.TIME_OUT),
        contentType: 'application/json; charset=utf-8',
        headers: {});

    /// 请求拦截器 and 响应拦截机 and 错误处理
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      debugPrint("\n================== 请求数据 ==========================");
      debugPrint("url = ${options.uri.toString()}");
      debugPrint("headers = ${options.headers}");
      debugPrint("params = ${options.data}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      debugPrint("\n================== 响应数据 ==========================");
      debugPrint("code = ${response.statusCode}");
      // debugPrint("data = ${response.data}");
      debugPrint("\n");
      handler.next(response);
    }, onError: (DioException e, handler) {
      debugPrint("\n================== 错误响应数据 ======================");
      debugPrint("type = ${e.type}");
      debugPrint("message = ${e.message}");
      debugPrint("\n");
      return handler.next(e);
    }));
  }
}
