import 'package:core/modules/env/env.dart';
import 'package:core/modules/network/const.dart';
import 'package:core/modules/network/error/network_error.dart';
import 'package:core/modules/network/error/type.dart';
import 'package:core/modules/network/network_lib.dart';
import 'package:core/modules/utility/helper.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class NetworkInterface {
  NetworkInterface._() : super();

  static NetworkInterface? _instance;

  static NetworkInterface get instance => _instance ??= NetworkInterface._();

  String? _userAgent = '';
  String? _osType = '';
  String? _deviceId = '';
  String? _deviceName = '';
  bool _isPhysicalDevice = true;
  NetworkLibrary library = NetworkLibrary();

  Future<Either<Response, NetworkError>> get({
    String? baseUrl,
    String? path,
    Map<String, dynamic>? queryParameters,
  }) async {
    baseUrl = baseUrl ?? Env.instance?.baseUrl;
    queryParameters?.addAll({
      "appid": Env.instance?.apiKey,
    });
    try {
      return await library
          .buildStandardDio(
            _buildBasicHeader(_userAgent, _osType),
          )
          .get("$baseUrl$path", queryParameters: queryParameters)
          .then((response) => Left(response));
    } on DioError catch (e, s) {
      Helper.catchError(e, s);
      return Right(_onError(e));
    } catch (e, s) {
      Helper.catchError(e, s);
      return Right(_onError(e));
    }
  }

  NetworkError _onError(Object e) {
    if (e is DioError) {
      if (e.response != null) {
        return NetworkError(
          (e.response!.data.runtimeType is Map ||
                  e.response!.data.toString()[0] == "{")
              ? e.response!.data['error'] ??
                  e.response!.data['message'] ??
                  NetworkConstant.unknownErrorMessage
              : NetworkConstant.unknownErrorMessage,
          NetworkErrorTypeParser.httpToErrorType(
              e.response!.statusCode ?? _errorCodeByDioErrorType(e)),
        );
      } else {
        return NetworkError(
          NetworkConstant.unknownErrorMessage,
          NetworkErrorTypeParser.httpToErrorType(_errorCodeByDioErrorType(e)),
        );
      }
    }
    return NetworkError();
  }

  int _errorCodeByDioErrorType(DioError e) {
    switch (e.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.connectTimeout:
        return NetworkConstant.connectionTimeoutErrorCode;
      default:
        return NetworkConstant.noConnectionErrorCode;
    }
  }

  Map<String, String?> _buildBasicHeader(String? userAgent, String? osType) {
    var headers = <String, String?>{};
    headers.putIfAbsent("content-type", () {
      return "application/json";
    });

    headers.putIfAbsent("User-Agent", () {
      return userAgent;
    });
    headers.putIfAbsent("os-type", () {
      return osType;
    });
    headers.putIfAbsent("device-id", () {
      return _deviceId;
    });
    headers.putIfAbsent("physical-device", () {
      return _deviceName;
    });
    headers.putIfAbsent("is-physical-device", () {
      return _isPhysicalDevice.toString();
    });

    return headers;
  }

  Future<void> setDevicePreference({
    String? appName,
    String? buildNumber,
    String? version,
    String? osType,
    String? deviceId,
    String? deviceName,
    String? sdkVersion,
    bool? isPhysicalDevice,
  }) async {
    _osType = osType;
    _deviceId = deviceId;
    _deviceName = deviceName;
    _isPhysicalDevice = isPhysicalDevice ?? false;
    _userAgent = Uri.encodeFull(
      '$appName/$version-$buildNumber ($_osType $sdkVersion $_deviceName)',
    );
  }
}
