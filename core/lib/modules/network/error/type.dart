import 'package:core/modules/network/const.dart';

enum NetworkErrorType {
  serverError,
  unprocessableEntity,
  badRequest,
  validationFailed,
  unauthenticated,
  noConnection,
  timeout,
  undefined,
  notfound,
}

class NetworkErrorTypeParser {
  static NetworkErrorType httpToErrorType(int http) {
    if (http >= 500) return NetworkErrorType.serverError;
    switch (http) {
      case NetworkConstant.noConnectionErrorCode: //dio error
        return NetworkErrorType.noConnection;
      case NetworkConstant.connectionTimeoutErrorCode: //dio error
        return NetworkErrorType.timeout;
      case 401:
        return NetworkErrorType.unauthenticated;
      case 400:
        return NetworkErrorType.badRequest;
      case 404:
        return NetworkErrorType.notfound;
      case 422:
        return NetworkErrorType.unprocessableEntity;
      default:
        return NetworkErrorType.undefined;
    }
  }
}
