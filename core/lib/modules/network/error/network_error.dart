import 'package:core/modules/network/const.dart';
import 'package:core/modules/network/error/type.dart';

class NetworkError {
  String message;
  NetworkErrorType type;

  NetworkError([
    this.message = NetworkConstant.unknownErrorMessage,
    this.type = NetworkErrorType.undefined,
  ]);

  NetworkError copyWith({
    String? message,
    NetworkErrorType? type,
  }) {
    return NetworkError(
      message ?? this.message,
      type ?? this.type,
    );
  }

  @override
  String toString() => 'NetworkError(message: $message, type: $type)';
}
