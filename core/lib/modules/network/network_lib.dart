// ignore_for_file: constant_identifier_names

import 'package:core/modules/logger/dio_logger.dart';
import 'package:dio/dio.dart';

class NetworkLibrary {
  NetworkLibrary();

  static const String TAG = 'NetworkLibrary';

  static const int TIMEOUT_MILLISECOND = 7000;

  Dio buildStandardDio<T>(Map<String, String?> headers) {
    var dio = Dio();
    dio.options.connectTimeout = TIMEOUT_MILLISECOND;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers.addAll(headers);
          DioLogger.onSend(TAG, options);
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          DioLogger.onSuccess(TAG, response);
          if (response.data is String && response.data.isEmpty) {
            response.data = <String, dynamic>{};
          } else if (response.data is List) {
            response.data = {'list': response.data};
          }
          return handler.next(response);
        },
        onError: (DioError error, ErrorInterceptorHandler handler) {
          DioLogger.onError(TAG, error);
          return handler.next(error);
        },
      ),
    );
    return dio;
  }
}
