import 'package:dio/dio.dart';

class Config {
  static const NOTE_URL = "http://192.168.21.102:5055";
  static const TIME_OUT = 10000;

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
        connectTimeout: Config.TIME_OUT,
        sendTimeout: Config.TIME_OUT,
        receiveTimeout: Config.TIME_OUT,
        contentType: 'application/json; charset=utf-8',
        headers: {});

    /// 请求拦截器 and 响应拦截机 and 错误处理
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print("\n================== 请求数据 ==========================");
      print("url = ${options.uri.toString()}");
      print("headers = ${options.headers}");
      print("params = ${options.data}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      print("\n================== 响应数据 ==========================");
      print("code = ${response.statusCode}");
      // print("data = ${response.data}");
      print("\n");
      handler.next(response);
    }, onError: (DioError e, handler) {
      print("\n================== 错误响应数据 ======================");
      print("type = ${e.type}");
      print("message = ${e.message}");
      print("\n");
      return handler.next(e);
    }));
  }
}
