import 'package:dio/dio.dart';

class Http {
  static Dio get apiURL {
    Dio dio = Dio();
    try {
      dio.options.baseUrl = 'https://mogapabahi-431fe4166879.herokuapp.com';
      dio.interceptors.addAll(
        [
          InterceptorsWrapper(
            onError: (e, handler) {
              return handler.next(e);
            },
            onRequest: (options, handler) async {
              return handler.next(options);
            },
            onResponse: (options, handler) {
              return handler.next(options);
            },
          ),
        ],
      );
    } catch (e) {
      // Handle initialization error
      print("Dio initialization error: $e");
    }
    return dio;
  }

  static Dio get others {
    Dio dio = Dio();
    try {
      dio.interceptors.addAll(
        [
          InterceptorsWrapper(
            onError: (e, handler) {
              return handler.next(e);
            },
            onRequest: (options, handler) {
              return handler.next(options);
            },
            onResponse: (options, handler) {
              return handler.next(options);
            },
          ),
        ],
      );
    } catch (e) {
      // Handle initialization error
      print("Dio initialization error: $e");
    }
    return dio;
  }
}
